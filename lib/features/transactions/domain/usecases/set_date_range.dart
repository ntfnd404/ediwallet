import '../../../../core/parammeters/date_range_parammeter.dart';
import '../repositories/i_preferences_repository.dart';

class SetDateRange {
  final IPreferencesRepository preferencesRepository;

  SetDateRange({required this.preferencesRepository});

  Future call(DateRangeParams params) async {
    preferencesRepository.setDateRange(
        startDate: params.startDate.toIso8601String(),
        endDate: params.endDate.toIso8601String());
  }
}
