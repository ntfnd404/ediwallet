import 'package:ediwallet/transaction_page/models/filter_chip.dart';

List<FilterChipData> filterChips() {
  return <FilterChipData>[
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
}

// Map<String, String> toJson(){
//           'name': name,
//         'isSelected': isSelected.toString(),

// }
