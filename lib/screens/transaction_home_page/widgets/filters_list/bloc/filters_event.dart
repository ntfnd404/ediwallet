import 'package:ediwallet/common/bloc/bloc_event.dart';

class FiltersEvent extends Event {
  FiltersEvent({this.index = 0, this.selected = false});

  final int index;
  final bool selected;

  @override
  List<Object> get props => [index, selected];
}
