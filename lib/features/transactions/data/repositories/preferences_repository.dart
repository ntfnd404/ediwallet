import '../../domain/repositories/i_preferences_repository.dart';
import '../datasources/preferences_data_source.dart';
import '../models/date_range_model.dart';

class PreferencesRepository implements IPreferencesRepository {
  final IPreferencesDataSource preferencesDataSource;

  PreferencesRepository({required this.preferencesDataSource});

  @override
  Future<void> setDateRange(
      {required String startDate, required String endDate}) async {
    preferencesDataSource.setDateRange(startDate: startDate, endDate: endDate);
  }

  @override
  DateRangeModel getDateRange() {
    return preferencesDataSource.getDateRange();
  }
}
