import 'package:shared_preferences/shared_preferences.dart';

import '../models/date_range_model.dart';

abstract class IPreferencesDataSource {
  DateRangeModel getDateRange();
  Future setDateRange({required String startDate, required String endDate});
}

class PreferencesDataSourceImpl implements IPreferencesDataSource {
  final SharedPreferences preferences;

  PreferencesDataSourceImpl({required this.preferences});

  @override
  DateRangeModel getDateRange() {
    final List<String>? _dateTimeString =
        preferences.getStringList('date_time');

    return DateRangeModel(
        startDate: _dateTimeString![0], endDate: _dateTimeString[1]);
  }

  @override
  Future setDateRange(
      {required String startDate, required String endDate}) async {
    preferences.setStringList('date_time', [startDate, endDate]);
  }
}
