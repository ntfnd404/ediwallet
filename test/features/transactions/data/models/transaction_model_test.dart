import 'package:ediwallet/features/transactions/data/models/transaction_model.dart';
import 'package:ediwallet/features/transactions/domain/entities/transaction_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main(List<String> args) {
  final tTransactionModel = TransactionModel(
      author: 'ntfnd404',
      department: 'КП',
      date: DateTime.now().toIso8601String(),
      sum: 5000,
      source: 'yandex.ru',
      time: '15:05:00',
      type: 'Наличные',
      user: 'Олег',
      analytics: 'Олег',
      mathSymbol: '+');

  test(
    'Должен быть наследником TransactionEntity',
    () async {
      //assert
      expect(tTransactionModel, isA<Transaction>());
    },
  );
}
