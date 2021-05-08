import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filters_event.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filters_state.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/models/filter_item.dart';

class FiltersListBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersListBloc() : super(const FiltersState(initial: true));

  final List<FilterItem> items = [
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
  ];

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is FiltersEvent) {
      if (!state.initial) {
        items[event.index].isSelected = !items[event.index].isSelected;
      }
      yield state.copyWith(items: items);
    }
  }
}
