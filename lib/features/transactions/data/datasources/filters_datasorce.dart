import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/filter_model.dart';

abstract class IFiltersDataSource {
  List<FilterModel> initialList();
  List<FilterModel> getFiltersList();
  String getJson();
  void setFilter(
      {required int index, required String name, required bool value});
}

class FiltersDataSource implements IFiltersDataSource {
  final SharedPreferences preferences;

  FiltersDataSource({required this.preferences});

  @override
  List<FilterModel> initialList() {
    final items = [
      const FilterModel(name: 'Поступления', isSelected: true),
      const FilterModel(name: 'Расходы', isSelected: true),
      const FilterModel(
        name: 'Тип оплаты',
      ),
      const FilterModel(
        name: 'ДДС',
      ),
      const FilterModel(
        name: 'Период',
      ),
      const FilterModel(
        name: 'Диапазон сумм',
      ),
    ];

    final List<String> encodedData = [];

    for (final filterModel in items) {
      encodedData.add(json.encode(filterModel.toJson()));
    }
    if (encodedData.isNotEmpty) {
      preferences.setStringList('filters', encodedData);
    }

    return items;
  }

  @override
  List<FilterModel> getFiltersList() {
    final _filtersValues = preferences.getStringList('filters');

    if (_filtersValues == null) {
      return initialList();
    } else {
      return _filtersValues
          .map((value) =>
              FilterModel.fromJson(json.decode(value) as Map<String, dynamic>))
          .toList();
    }
  }

  @override
  String getJson() {
    final List<String>? _filtersValues = preferences.getStringList('filters');

    if (_filtersValues != null) {
      final StringBuffer buffer = StringBuffer();
      buffer.clear();
      for (final item in _filtersValues) {
        buffer.write(item);
      }

      return '[${buffer.toString()}]';
    }

    throw ServerException();
  }

  @override
  Future setFilter(
      {required int index, required String name, required bool value}) async {
    final List<String>? _filterStrings = preferences.getStringList('filters');
    if (_filterStrings != null) {
      _filterStrings[index] = '{"name":"$name", "isSelected":$value}';
      preferences.setStringList('filters', _filterStrings);
    }
  }
}
