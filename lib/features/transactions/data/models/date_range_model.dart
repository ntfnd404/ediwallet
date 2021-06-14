import '../../domain/entities/date_range_entity.dart';

class DateRangeModel extends DateRange {
  const DateRangeModel({required String startDate, required String endDate})
      : super(startDate: startDate, endDate: endDate);

  @override
  List<Object?> get props => [startDate, endDate];

  factory DateRangeModel.fromDate(
      {required DateTime startDate, required DateTime endDate}) {
    return DateRangeModel(
        startDate: startDate.toIso8601String(),
        endDate: endDate.toIso8601String());
  }
}
