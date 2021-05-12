import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'date_range_state.dart';

class DaterangeCubit extends Cubit<DaterangeState> {
  DaterangeCubit()
      : super(
          DaterangeState(
            DateTime.now().add(const Duration(days: -7)),
            DateTime.now(),
          ),
        );

  Future<void> setDateTime(
      {required DateTime firstDate, required DateTime lastDate}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'date_time', [firstDate.toString(), lastDate.toString()]);

    emit(DaterangeState(
      firstDate,
      lastDate,
    ));
  }

  Future<void> getDateTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? _dateTimeRange = prefs.getStringList('date_time');

    if (_dateTimeRange == null) {
      await prefs.setStringList(
          'date_time', [state.firstDate.toString(), state.lastDate.toString()]);
    }
    final DateTime _firstDate = _dateTimeRange == null
        ? state.firstDate
        : DateTime.parse(_dateTimeRange[0]);
    final DateTime _lastDate = _dateTimeRange == null
        ? state.lastDate
        : DateTime.parse(_dateTimeRange[1]);

    emit(DaterangeState(
      _firstDate,
      _lastDate,
    ));
  }
}
