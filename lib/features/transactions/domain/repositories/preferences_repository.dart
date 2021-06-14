import '../../data/models/date_range_model.dart';

abstract class PreferencesRepository {
  Future<void> setDateRange(
      {required String startDate, required String endDate});

  Future<DateRangeModel> getDateRange();
}
