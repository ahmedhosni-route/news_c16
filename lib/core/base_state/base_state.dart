sealed class BaseState<T> {
  T? data;
  String? message;
  BaseState({this.data , this.message});
}

class LoadingState<T> extends BaseState<T> {}

class SuccessState<T> extends BaseState<T> {
  SuccessState({required super.data});
}

class ErrorState<T> extends BaseState<T> {
  ErrorState({super.message});
}

