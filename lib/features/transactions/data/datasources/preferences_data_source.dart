import 'package:ediwallet/features/transactions/data/models/date_range_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesDataSource {
  Future<void> setDateRange(
      {required String startDate, required String endDate});
  Future<DateRangeModel> getDateRange();
}

class PreferencesDataSourceImpl implements PreferencesDataSource {
  final SharedPreferences preferences;

  PreferencesDataSourceImpl({required this.preferences});

  @override
  Future<DateRangeModel> getDateRange() async {
    final List<String>? _dateTimeString =
        preferences.getStringList('date_time');

    final DateRangeModel _dateRangeModel = DateRangeModel(
        startDate: _dateTimeString![0], endDate: _dateTimeString[1]);

    return Future.value(_dateRangeModel);
  }

  @override
  Future<void> setDateRange(
      {required String startDate, required String endDate}) async {
    await preferences.setStringList('date_time', [startDate, endDate]);
  }
}
