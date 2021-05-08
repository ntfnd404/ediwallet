import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/models/filter_item.dart';

class Filters {
  final List<FilterItem> _items = [
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

  List<FilterItem> get items => _items;

  String toJson() {
    final StringBuffer buffer = StringBuffer();
    buffer.clear();
    for (final item in _items) {
      buffer.write(
        '{"name":"${item.name}","isSelected":"${item.isSelected.toString()}"},',
      );
    }
    final String _result = buffer.toString();

    return '[${_result.substring(0, _result.length - 1)}]';
  }
}
