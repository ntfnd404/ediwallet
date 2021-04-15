class Transaction {
  final String author;
  final String department;
  final String date;
  final int sum;
  final String source;
  final String time;
  final String type;
  final String user;
  final String mathSymbol;

  Transaction(this.author, this.department, this.date, this.sum, this.source,
      this.time, this.type, this.user, this.mathSymbol);

  factory Transaction.fromJson(dynamic json) {
    return Transaction(
        json['author'] as String,
        json['department'] as String,
        json['date'] as String,
        json['sum'] as int,
        json['source'] as String,
        json['time'] as String,
        json['type'] as String,
        json['user'] as String,
        json['mathSymbol']);
  }
}
