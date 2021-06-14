import '../../../../core/parammeters/date_range_parammeter.dart';
import '../repositories/preferences_repository.dart';

class SetDateRange {
  final PreferencesRepository preferencesRepository;

  SetDateRange({required this.preferencesRepository});

  Future<void> call(DateRangeParams params) async {
    await preferencesRepository.setDateRange(
        startDate: params.startDate.toIso8601String(),
        endDate: params.endDate.toIso8601String());
  }
}
