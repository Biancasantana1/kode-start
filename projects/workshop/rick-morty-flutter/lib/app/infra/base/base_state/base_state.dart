import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  String get message => '';
}

class IdleState extends BaseState {
  const IdleState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends BaseState {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

class SuccessState extends BaseState {
  @override
  final String message;

  const SuccessState({this.message = ''});

  @override
  List<Object?> get props => [message];
}

class FailureState extends BaseState {
  @override
  final String message;

  const FailureState(this.message);

  @override
  List<Object?> get props => [message];
}
