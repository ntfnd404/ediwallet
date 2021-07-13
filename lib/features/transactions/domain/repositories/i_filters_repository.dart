import '../entities/filter_entity.dart';

abstract class IFiltersRepository {
  void setFilter(
      {required int index, required String name, required bool value});
  List<FilterItem> getFiltersList();
  String getJson();
}
