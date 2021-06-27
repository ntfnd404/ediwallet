import '../../domain/repositories/preferences_repository.dart';
import '../datasources/preferences_data_source.dart';
import '../models/date_range_model.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final IPreferencesDataSource preferencesDataSource;

  PreferencesRepositoryImpl({required this.preferencesDataSource});

  @override
  Future<void> setDateRange(
      {required String startDate, required String endDate}) async {
    await preferencesDataSource.setDateRange(
        startDate: startDate, endDate: endDate);
  }

  @override
  Future<DateRangeModel> getDateRange() async {
    return preferencesDataSource.getDateRange();
  }
}
