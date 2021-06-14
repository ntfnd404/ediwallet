part of 'filters_list_bloc.dart';

class FiltersEvent extends Equatable {
  const FiltersEvent({this.index = 0, this.selected = false});

  final int index;
  final bool selected;

  @override
  List<Object> get props => [index, selected];
}
