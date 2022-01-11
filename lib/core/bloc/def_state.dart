import 'package:equatable/equatable.dart';

mixin DefState<S> {
  S rebuild(Function(dynamic) updates);

  bool get isLoading;

  bool get isError => error?.errorMessage.isNotEmpty ?? false;

  BlocStateError? get error;

  S setLoading(bool isLoading) {
    return rebuild((b) => (b)..isLoading = isLoading);
  }

  S failure(String? message) {
    return rebuild((b) => (b)..error = message != null? BlocStateError(message) : null);
  }

  S invalidateErrorMessage() {
    return rebuild((b) => (b)..errorMessage = null);
  }
}

class BlocStateError extends Equatable{
  final String errorMessage;

  const BlocStateError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}