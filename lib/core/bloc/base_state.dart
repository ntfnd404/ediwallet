import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class NoInternetConnectionState extends BaseState {}

class FailureState extends BaseState {}

class LoadingState extends BaseState {}

class InitialState extends BaseState {}
