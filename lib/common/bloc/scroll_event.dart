import 'package:equatable/equatable.dart';

abstract class Event extends Equatable {
  @override
  List<Object> get props => [];
}

class ScrollEvent extends Event {
  ScrollEvent({this.isRefresh = false});

  final bool isRefresh;

  @override
  List<Object> get props => [isRefresh];
}
