import 'dart:convert';

class Transaction {
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

  Transaction(this.author, this.department, this.date, this.sum, this.source,
      this.time, this.type, this.user, this.analytics, this.mathSymbol);

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

  String clientToJson(Transaction transaction) {
    final transactionJson = transaction.toJson();
    return json.encode(transactionJson);
  }

  Map<String, String> toJson() => {
        'author': author,
        'department': department,
        'date': date,
        'sum': sum.toString(),
      };

  // factory String.toJson(Transaction transaction) {
  //   Map<String, Transaction>() => {
  //         "author": author,
  //         "department": department,
  //         "date": date,
  //         "sum": sum,
  //       };

  //   return "rr";
  //   // return json.encode(d);
  // }
}
