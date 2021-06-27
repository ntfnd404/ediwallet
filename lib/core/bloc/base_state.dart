import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemsListSuccessState<T> extends BaseState {
  final bool hasReachedMax;
  final List<T> items;

  ItemsListSuccessState({
    this.hasReachedMax = false,
    this.items = const [],
  });

  @override
  List<Object> get props => [items, hasReachedMax];
}

class NoInternetConnectionState extends BaseState {}

class FailureState extends BaseState {}

class LoadingState extends BaseState {}

class InitialState extends BaseState {}
