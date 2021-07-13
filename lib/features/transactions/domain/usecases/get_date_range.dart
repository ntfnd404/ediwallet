import '../../data/models/date_range_model.dart';
import '../entities/date_range_entity.dart';
import '../repositories/i_preferences_repository.dart';

class GetDateRange {
  final IPreferencesRepository preferencesRepository;

  GetDateRange({required this.preferencesRepository});

  Future<DateRange> call() async {
    final DateRangeModel _dateRangeModel = preferencesRepository.getDateRange();

    final DateRange _dataRange = DateRange(
        startDate: _dateRangeModel.startDate, endDate: _dateRangeModel.endDate);
    return Future.value(_dataRange);
  }
}
