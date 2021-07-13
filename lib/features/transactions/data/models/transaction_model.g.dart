// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
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
    mathSymbol: json['mathSymbol'] as String,
  );
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'department': instance.department,
      'date': instance.date,
      'sum': instance.sum,
      'source': instance.source,
      'time': instance.time,
      'type': instance.type,
      'user': instance.user,
      'analytics': instance.analytics,
      'mathSymbol': instance.mathSymbol,
    };
