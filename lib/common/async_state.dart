import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AsyncState<T> extends Equatable {
  final T? payload;
  final bool inProgress;
  final Object? error;
  bool get hasError => error != null;
  bool get hasData => payload != null;

  const AsyncState({this.payload, required this.inProgress, this.error});

  @override
  List<Object?> get props => [payload, inProgress, error];
}

@immutable
class PagedListAsyncState<T> extends AsyncState<Iterable<T>> {
  final int page;
  final bool isFinished;
  const PagedListAsyncState(this.page,
      {required Iterable<T> payload,
      bool inProgress = false,
      dynamic error,
      this.isFinished = false})
      : super(payload: payload, inProgress: inProgress, error: error);

  factory PagedListAsyncState.inProgress(int page,
          {required Iterable<T> payload}) =>
      PagedListAsyncState(page, payload: payload, inProgress: true);

  factory PagedListAsyncState.error(int page, Object error,
          {required Iterable<T> payload}) =>
      PagedListAsyncState(page,
          payload: payload, inProgress: false, error: error);

  factory PagedListAsyncState.success(int page, Iterable<T> payload,
          {bool isFinished = false}) =>
      PagedListAsyncState(page,
          payload: payload, inProgress: false, isFinished: isFinished);

  @override
  List<Object> get props => [page, isFinished, inProgress];

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is PagedListAsyncState &&
  //         runtimeType == other.runtimeType &&
  //         page == other.page &&
  //         inProgress == other.inProgress &&
  //         error == other.error &&
  //         isFinished == other.isFinished &&
  //         iterableEquals(payload, other.payload);

  // @override
  // int get hashCode =>
  //     error.hashCode ^
  //     inProgress.hashCode ^
  //     page.hashCode ^
  //     isFinished.hashCode ^
  //     identityHashCode(payload);

  // bool iterableEquals(Iterable<T>? payload, Iterable? payload2) =>
  //    const iterableEquals<Object>().equals(payload, payload2);

}
