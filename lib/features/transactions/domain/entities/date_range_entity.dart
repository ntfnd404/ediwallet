import 'package:equatable/equatable.dart';

class DateRange extends Equatable {
  final String startDate;
  final String endDate;

  const DateRange({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}
