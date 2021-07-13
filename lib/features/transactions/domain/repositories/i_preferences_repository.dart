import '../../data/models/date_range_model.dart';

abstract class IPreferencesRepository {
  Future<void> setDateRange(
      {required String startDate, required String endDate});

  DateRangeModel getDateRange();
}
