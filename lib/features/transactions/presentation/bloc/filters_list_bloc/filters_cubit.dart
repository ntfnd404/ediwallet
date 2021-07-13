import 'package:bloc/bloc.dart';

import '../../../domain/entities/filter_entity.dart';
import '../../../domain/repositories/i_filters_repository.dart';
import 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  final IFiltersRepository filtersRepository;

  FiltersCubit({required this.filtersRepository})
      : super(FiltersState(items: filtersRepository.getFiltersList()));

  Future getFilters() async {
    emit(FiltersState(items: _getFiltersList()));
  }

  Future setFilter(
      {required int index, required String name, required bool value}) async {
    filtersRepository.setFilter(index: index, name: name, value: value);
    emit(state.copyWith(items: _getFiltersList()));
  }

  Future clearFilter({required int index, required String name}) async {
    // filtersRepository.setFilter(index: index, name: name, value: value);
    // emit(state.copyWith(items: _getFiltersList()));
  }

  List<FilterItem> _getFiltersList() {
    return filtersRepository.getFiltersList();
  }
}
