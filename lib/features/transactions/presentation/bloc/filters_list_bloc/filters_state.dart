part of 'filters_list_bloc.dart';

class FiltersState extends Equatable {
  final List<FilterItem> items;

  const FiltersState({this.items = const []});

  @override
  List<Object> get props => [items];

  FiltersState copyWith({List<FilterItem>? items}) {
    return FiltersState(items: items ?? this.items);
  }
}
