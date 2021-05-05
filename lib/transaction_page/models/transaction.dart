import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  const Transaction(
      this.author,
      this.department,
      this.date,
      this.sum,
      this.source,
      this.time,
      this.type,
      this.user,
      this.analytics,
      this.mathSymbol);

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

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        json['author'] as String,
        json['department'] as String,
        json['date'] as String,
        json['sum'] as int,
        json['source'] as String,
        json['time'] as String,
        json['type'] as String,
        json['user'] as String,
        json['analytics'] as String,
        json['mathSymbol'] as String);
  }

  Map<String, String> toJson() => {
        'author': author,
        'department': department,
        'date': date,
        'sum': sum.toString(),
      };
}
