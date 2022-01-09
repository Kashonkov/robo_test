
abstract class UseCase<Type, Params>{
  Future<UseCaseResult<Type>> call(Params params);
}

abstract class SyncUseCase<Type, Params>{
  Type call(Params params);
}

class EmptyUseCaseParams{}

class UseCaseResult<T>{
  final T? result;
  final Exception? exception;

  UseCaseResult(this.result, this.exception);

  factory UseCaseResult.successful(T? result) => UseCaseResult(result, null);
  factory UseCaseResult.error(Exception e) => UseCaseResult(null, e);

  bool get isSuccessful => exception == null;
}