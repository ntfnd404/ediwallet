import '../bloc_event.dart';

class ScrollEvent extends Event {
  ScrollEvent(
      {this.isRefresh = false,
      this.firstDate,
      this.lastDate,
      this.filterSettings});

  final bool isRefresh;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? filterSettings;

  @override
  List<Object> get props => [isRefresh, firstDate!, lastDate!];
}
