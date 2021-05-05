import 'package:ediwallet/transaction_page/models/filter_chip.dart';
import 'package:flutter/material.dart';

class FiltersBar extends ChangeNotifier {
  final List<FilterChipData> _items = [
    FilterChipData(name: 'Поступления', isSelected: true),
    FilterChipData(name: 'Расходы', isSelected: true),
    FilterChipData(
      name: 'Тип оплаты',
    ),
    FilterChipData(
      name: 'ДДС',
    ),
    FilterChipData(
      name: 'Период',
    ),
    FilterChipData(
      name: 'Диапазон сумм',
    ),
  ];

  List<FilterChipData> get items => _items;

  void changeItem(int index) {
    _items[index].isSelected = !_items[index].isSelected;
    notifyListeners();
  }

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
