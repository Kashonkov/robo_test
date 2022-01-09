import 'dart:async';

typedef ResultT RunnableFunction<ResultT>(Object? args);

class Runnable<ResultT> {
  final RunnableFunction<ResultT> func;
  final Object? args;

  Runnable({
    required this.func,
    this.args,
  });

  FutureOr<ResultT> call() {
    return func(args);
  }
}