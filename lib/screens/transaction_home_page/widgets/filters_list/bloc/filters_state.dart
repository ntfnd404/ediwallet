import 'package:equatable/equatable.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/models/filter_item.dart';

class FiltersState extends Equatable {
  const FiltersState({this.initial = false, this.items = const []});

  final bool initial;
  final List<FilterItem> items;

  @override
  List<Object> get props => [items];

  FiltersState copyWith(
          {bool? initial = false,
          required List<FilterItem>? items,
          String? errorMessage}) =>
      FiltersState(
          initial: initial ?? this.initial, items: items ?? this.items);
}
