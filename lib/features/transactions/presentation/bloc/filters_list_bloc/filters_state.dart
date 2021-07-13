// part of 'filters_list_bloc.dart';

import 'package:ediwallet/core/bloc/base_state.dart';
import 'package:ediwallet/features/transactions/domain/entities/filter_entity.dart';

class FiltersState extends BaseState {
  final List<FilterItem> items;

  FiltersState({this.items = const []});

  @override
  List<Object> get props => [items];

  FiltersState copyWith({List<FilterItem>? items}) {
    return FiltersState(items: items ?? this.items);
  }
}
