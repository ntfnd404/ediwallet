import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends Transaction {
  const TransactionModel(
      {required String author,
      required String department,
      required String date,
      required int sum,
      required String source,
      required String time,
      required String type,
      required String user,
      required String analytics,
      required String mathSymbol})
      : super(
            author: author,
            department: department,
            date: date,
            sum: sum,
            source: source,
            time: time,
            type: type,
            user: user,
            analytics: analytics,
            mathSymbol: mathSymbol);

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        author: json['author'] as String,
        department: json['department'] as String,
        date: json['date'] as String,
        sum: json['sum'] as int,
        source: json['source'] as String,
        time: json['time'] as String,
        type: json['type'] as String,
        user: json['user'] as String,
        analytics: json['analytics'] as String,
        mathSymbol: json['mathSymbol'] as String);
  }

  Map<String, dynamic> toJson() => {
        'author': author,
        'department': department,
        'date': date,
        'sum': sum,
      };
}
