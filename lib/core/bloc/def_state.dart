mixin DefState<S> {
  S rebuild(Function(dynamic) updates);

  bool get isLoading;

  bool get isError => error?.errorMessage.isNotEmpty ?? false;

  StateError? get error;

  S setLoading(bool isLoading) {
    return rebuild((b) => (b)..isLoading = isLoading);
  }

  S failure(String? message) {
    return rebuild((b) => (b)..error = message != null? StateError(message) : null);
  }

  S invalidateErrorMessage() {
    return rebuild((b) => (b)..errorMessage = null);
  }
}

class StateError{
  final String errorMessage;

  StateError(this.errorMessage);
}