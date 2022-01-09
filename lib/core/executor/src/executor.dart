import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:robo_test/core/executor/src/cancelable.dart';
import 'package:robo_test/core/executor/src/task.dart';
import 'package:robo_test/core/executor/src/work_priority.dart';

import 'isolate_wrapper/isolate_wrapper.dart';
import 'number_of_processors/processors_web.dart' if (dart.library.io) 'number_of_processors/processors_io.dart';
import 'runnable.dart';

abstract class Executor {
  factory Executor() => _Executor();

  Future<void> warmUp({bool log = false, int? isolatesCount});

  Cancelable<ResultT> fakeExecute<ResultT>(
      {required RunnableFunction<ResultT> func, Object? args, WorkPriority priority = WorkPriority.regular});

  Cancelable<ResultT> execute<ResultT>(
      {required RunnableFunction<ResultT> func, Object? args, WorkPriority priority = WorkPriority.regular});
}

class _Executor implements Executor {
  final _queue = PriorityQueue<Task>();
  final _pool = <IsolateWrapper>[];
  var _taskNumber = pow(-2, 53);
  var _log = false;

  _Executor._internal();

  static final _instance = _Executor._internal();

  factory _Executor() => _instance;

  @override
  Future<void> warmUp({bool log = false, int? isolatesCount}) async {
    _log = log;
    final processors = numberOfProcessors;
    isolatesCount ??= processors;
    var processorsNumber = isolatesCount < processors ? isolatesCount : processors;
    if (processorsNumber == 1) processorsNumber = 2;
    for (var i = 0; i < processorsNumber - 1; i++) {
      _pool.add(IsolateWrapper());
    }
    logInfo('${_pool.length} has been spawned');
    await Future.wait(_pool.map((iw) => iw.initialize()));
    logInfo('initialized');
  }

  @override
  Cancelable<ResultT> execute<ResultT>(
      {required RunnableFunction<ResultT> func, Object? args, WorkPriority priority = WorkPriority.regular}) {
    final task = Task<ResultT>(_taskNumber.toInt(), runnable: Runnable(func: func, args: args), workPriority: priority);
    logInfo('inserted task with number $_taskNumber');
    _taskNumber++;
    _queue.add(task);
    _schedule();
    return Cancelable(task.resultCompleter, () => _cancel(task));
  }

  void _schedule() {
    IsolateWrapper? availableIsolate;
    try {
      availableIsolate = _pool.firstWhere((iw) => iw.runnableNumber == null);
    } catch (e) {
      availableIsolate = null;
    }
    if (availableIsolate != null) {
      final task = _queue.removeFirst();
      availableIsolate.runnableNumber = task.number;
      logInfo('isolate with task number ${availableIsolate.runnableNumber} begins work');
      availableIsolate.work(task).then((result) {
        if (_log) {
          print('isolate with task number ${task.number} ends work');
        }
        task.resultCompleter.complete(result);
        _scheduleNext();
      }).catchError((error) {
        task.resultCompleter.completeError(error);
        _scheduleNext();
      });
    } else {
      print("there is no epmty isolates");
    }
  }

  void _scheduleNext() {
    if (_queue.isNotEmpty) _schedule();
  }

  void _cancel<ResultT>(Task<ResultT> task) {
    if (!task.resultCompleter.isCompleted) {
      task.resultCompleter.completeError(CanceledError());
    }
    if (_queue.contains(task)) {
      logInfo('task with number ${task.number} removed from queue');
      _queue.remove(task);
    } else {
      IsolateWrapper? targetWrapper;
      try {
        targetWrapper = _pool.firstWhere((iw) => iw.runnableNumber == task.number);
      } catch (e) {
        targetWrapper = null;
      }
      if (targetWrapper != null) {
        logInfo('isolate with number ${targetWrapper.runnableNumber} killed');
        targetWrapper.kill().then((_) {
          targetWrapper!.initialize().then((_) {
            _scheduleNext();
          });
        });
      }
    }
  }

  @override
  Cancelable<ResultT> fakeExecute<ResultT>(
      {required RunnableFunction<ResultT> func, Object? args, WorkPriority priority = WorkPriority.regular}) {
    final task = Task(
      _taskNumber.toInt(),
      runnable: Runnable(func: func, args: args),
      workPriority: priority,
    );
    _taskNumber++;

    if (task.runnable() is Future<ResultT>) {
      (task.runnable() as Future<ResultT>).then((data) {
        task.resultCompleter.complete(data);
      });
    } else {
      task.resultCompleter.complete(task.runnable());
    }

    return Cancelable<ResultT>(task.resultCompleter as Completer<ResultT>, () => print('cant cancel fake task'));
  }

  void logInfo(String info) {
    if (_log) {
      print(info);
    }
  }
}
