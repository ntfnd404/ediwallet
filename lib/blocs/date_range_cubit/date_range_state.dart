part of 'date_range_cubit.dart';

class DaterangeState extends Equatable {
  final DateTime firstDate;
  final DateTime lastDate;

  const DaterangeState(this.firstDate, this.lastDate);

  @override
  List<Object> get props => [firstDate, lastDate];
}
