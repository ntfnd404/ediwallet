import 'package:equatable/equatable.dart';

import 'filter_item.dart';

class Filters extends Equatable {
  final List<FilterItem> items = [
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
  List<Object?> get props => [items];

  String toJson() {
    final StringBuffer buffer = StringBuffer();
    buffer.clear();
    for (final item in items) {
      buffer.write(
        '{"name":"${item.name}","isSelected":"${item.isSelected.toString()}"},',
      );
    }
    final String _result = buffer.toString();

    return '[${_result.substring(0, _result.length - 1)}]';
  }
}
