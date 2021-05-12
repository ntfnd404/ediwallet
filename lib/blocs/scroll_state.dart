import 'package:equatable/equatable.dart';

enum StateStatus { initial, success, failure }

class ScrollState<T> extends Equatable {
  final StateStatus status;
  final bool hasReachedMax;
  final List<T> items;

  const ScrollState({
    this.status = StateStatus.initial,
    this.items = const [],
    this.hasReachedMax = false,
  });

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
