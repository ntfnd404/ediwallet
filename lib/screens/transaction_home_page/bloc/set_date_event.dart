import 'package:ediwallet/common/bloc/bloc_event.dart';

class SetDateEvent extends Event {
  SetDateEvent(this.startDate, this.endDate);

  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object> get props => [startDate, endDate];
}
