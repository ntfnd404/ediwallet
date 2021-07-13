import '../../domain/entities/filter_entity.dart';
import '../../domain/repositories/i_filters_repository.dart';
import '../datasources/filters_datasorce.dart';

class FiltersRepository implements IFiltersRepository {
  final IFiltersDataSource remoteDataSource;

  FiltersRepository({required this.remoteDataSource});

  @override
  void setFilter(
      {required int index, required String name, required bool value}) {
    remoteDataSource.setFilter(index: index, name: name, value: value);
  }

  @override
  List<FilterItem> getFiltersList() {
    return remoteDataSource.getFiltersList();
  }

  @override
  String getJson() {
    return remoteDataSource.getJson();
  }
}
