import 'package:equatable/equatable.dart';

class DateRangeParams extends Equatable {
  final DateTime startDate;
  final DateTime endDate;

  const DateRangeParams({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate];
}
