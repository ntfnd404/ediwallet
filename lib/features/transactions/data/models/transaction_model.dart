import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
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

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
