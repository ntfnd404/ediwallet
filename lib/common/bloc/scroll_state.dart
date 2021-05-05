import 'package:equatable/equatable.dart';

enum StateStatus { initial, success, failure }

abstract class BaseScrollState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScrollState<T> extends BaseScrollState {
  ScrollState({
    this.status = StateStatus.initial,
    this.items = const [],
    this.hasReachedMax = false,
  });

  final StateStatus status;
  final List<T> items;
  final bool hasReachedMax;

  @override
  List<Object> get props => [status, items, hasReachedMax];

  ScrollState<T> copyWith({
    StateStatus? status,
    List<T>? items,
    bool? hasReachedMax,
  }) {
    return ScrollState<T>(
      status: status ?? this.status,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
