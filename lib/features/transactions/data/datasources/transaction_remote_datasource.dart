import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exception.dart';
import '../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<void> addTransaction({required String authKey});

  Future<List<TransactionModel>> getAllTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters});
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  Client client;

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<void> addTransaction({required String authKey}) {
    // TODO: implement addTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters}) async {
    final Response response = await client.post(
        Uri.https('edison.group', '/cstest/hs/bookkeeping/pays'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $authKey'
        },
        body:
            '{"FirstPage":"$page","StartDate":"$startDate","EndDate":"$endDate","Filters":$filters}');

    if (response.statusCode == 200) {
      final List body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw ServerException();
  }
}
