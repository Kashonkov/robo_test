import 'dart:async';

import 'package:robo_test/core/executor/src/runnable.dart';
import 'package:robo_test/core/executor/src/work_priority.dart';

class Task<ResultT> implements Comparable<Task> {
  final Runnable runnable;
  final resultCompleter = Completer<ResultT>();
  final int number;
  final WorkPriority workPriority;

  Task(this.number, {required this.runnable, required this.workPriority});

  @override
  int compareTo(Task other) {
    final index = WorkPriority.values.indexOf;
    return index(workPriority) - index(other.workPriority);
  }
}
