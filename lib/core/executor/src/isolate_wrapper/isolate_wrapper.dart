import 'dart:async';

import '../task.dart';
import 'isolate_wrapper_io.dart';

abstract class IsolateWrapper {
  int? runnableNumber;

  Future<void> initialize();

  Future<void> kill();

  Future<ResultT> work<ResultT>(Task<ResultT> task);

  factory IsolateWrapper() => IsolateWrapperImpl();
}

class Message {
  final Function function;
  final Object argument;

  Message(this.function, this.argument);

  FutureOr<Object> call() async => await function(argument);
}
