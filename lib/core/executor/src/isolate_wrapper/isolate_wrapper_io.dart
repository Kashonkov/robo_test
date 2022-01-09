import 'dart:async';
import 'dart:isolate';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:robo_test/core/executor/src/isolate_wrapper/isolate_wrapper.dart';
import 'package:robo_test/core/executor/src/runnable.dart';
import 'package:robo_test/core/executor/src/task.dart';


class IsolateWrapperImpl implements IsolateWrapper {
  @override
  int? runnableNumber;

  Isolate? _isolate;
  ReceivePort? _receivePort;
  SendPort? _sendPort;
  StreamSubscription<dynamic>? _portSub;
  Completer<dynamic>? _result;

  @override
  Future<void> initialize() async {
    final initCompleter = Completer<bool>();
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_anotherIsolate, _receivePort!.sendPort);
    _portSub = _receivePort!.listen((message) {
      if (message is ValueResult) {
        _result?.complete(message.value);
      } else if (message is ErrorResult) {
        _result?.completeError(message.error);
      } else {
        _sendPort = message;
        initCompleter.complete(true);
      }
      runnableNumber = null;
    });
    await initCompleter.future;
  }

  @override
  Future<ResultT> work<ResultT>(Task<ResultT> task) async{
    runnableNumber = task.number;
    _result = Completer<ResultT>();
    _sendPort!.send(Message(_execute, task.runnable));
    return _result!.future as Future<ResultT>;
  }

  static FutureOr _execute(Runnable runnable) => runnable();

  static void _anotherIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen((message) async {
      try {
        final currentMessage = message as Message;
        final function = currentMessage.function;
        final argument = currentMessage.argument;
        final result = await function(argument);
        sendPort.send(Result.value(result));
      } catch (error) {
        try {
          debugPrintStack(stackTrace: AsyncError.defaultStackTrace(error), label: error.toString());
          sendPort.send(Result.error(error.toString()));
        } catch (error) {
          sendPort.send(Result.error(
              'cant send error with too big stackTrace, error is : ${error.toString()}'));
        }
      }
    });
  }

  @override
  Future<void> kill() async {
    await _portSub?.cancel();
    _result = null;
    _sendPort = null;
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }
}

class Message {
  final Function function;
  final Object argument;

  Message(this.function, this.argument);

  FutureOr<Object> call() async => await function(argument);
}

abstract class IsolateStatusListener{
  jobFinished();
}