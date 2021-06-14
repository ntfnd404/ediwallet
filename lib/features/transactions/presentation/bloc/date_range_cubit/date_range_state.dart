part of 'date_range_cubit.dart';

class DateRangeState extends Equatable {
  final DateTime firstDate;
  final DateTime lastDate;

  const DateRangeState(this.firstDate, this.lastDate);

  @override
  List<Object> get props => [firstDate, lastDate];
}
