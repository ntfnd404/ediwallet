import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/parammeters/date_range_parammeter.dart';
import '../../../domain/entities/date_range_entity.dart';
import '../../../domain/usecases/get_date_range.dart';
import '../../../domain/usecases/set_date_range.dart';

part 'date_range_state.dart';

class DateRangeCubit extends Cubit<DateRangeState> {
  final SetDateRange setDataRange;
  final GetDateRange getDateRange;

  DateRangeCubit({required this.setDataRange, required this.getDateRange})
      : super(initialState);

  // TODO: сделать через FutureBilder
  static DateRangeState get initialState {
    return DateRangeState(
      DateTime.now().add(const Duration(days: -7)),
      DateTime.now(),
    );
  }

  Future setDateTime(
      {required DateTime firstDate, required DateTime lastDate}) async {
    setDataRange(DateRangeParams(startDate: firstDate, endDate: lastDate));
    emit(DateRangeState(
      firstDate,
      lastDate,
    ));
  }

  Future<void> getDateTime() async {
    final DateRange _dateRange = await getDateRange();
    emit(DateRangeState(
      DateTime.parse(_dateRange.startDate),
      DateTime.parse(_dateRange.endDate),
    ));
  }
}
