import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/filter_item.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersListBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersListBloc()
      : super(
          const FiltersState(
            items: [
              FilterItem(name: 'Поступления', isSelected: true),
              FilterItem(name: 'Расходы', isSelected: true),
              FilterItem(
                name: 'Тип оплаты',
              ),
              FilterItem(
                name: 'ДДС',
              ),
              FilterItem(
                name: 'Период',
              ),
              FilterItem(
                name: 'Диапазон сумм',
              ),
            ],
          ),
        );

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final List<FilterItem> _repositoryItems = [
    const FilterItem(name: 'Поступления', isSelected: true),
    const FilterItem(name: 'Расходы', isSelected: true),
    const FilterItem(
      name: 'Тип оплаты',
    ),
    const FilterItem(
      name: 'ДДС',
    ),
    const FilterItem(
      name: 'Период',
    ),
    const FilterItem(
      name: 'Диапазон сумм',
    ),
  ];

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is FiltersEvent) {
      _repositoryItems[event.index] =
          state.items[event.index].copyWith(isSelected: event.selected);
      final _items = List<FilterItem>.unmodifiable(_repositoryItems);

      yield state.copyWith(items: _items);
    }
  }
}
