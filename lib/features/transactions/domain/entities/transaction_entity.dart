import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String author;
  final String department;
  final String date;
  final int sum;
  final String source;
  final String time;
  final String type;
  final String user;
  final String analytics;
  final String mathSymbol;

  const Transaction({
    required this.author,
    required this.department,
    required this.date,
    required this.sum,
    required this.source,
    required this.time,
    required this.type,
    required this.user,
    required this.analytics,
    required this.mathSymbol,
  });

  @override
  List<Object?> get props => [
        author,
        department,
        date,
        sum,
        source,
        time,
        type,
        user,
        analytics,
        mathSymbol
      ];
}
