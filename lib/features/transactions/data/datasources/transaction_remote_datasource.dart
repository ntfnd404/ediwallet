import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exception.dart';
import '../models/transaction_model.dart';

abstract class ITransactionRemoteDataSource {
  Future<void> addTransaction(
      {required String authKey,
      required int paymentType,
      required String sourceId,
      required String departmentId,
      required String employeeId,
      required String employeeType,
      required String sum});

  Future<List<TransactionModel>> getTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters});
}

class TransactionRemoteDataSource implements ITransactionRemoteDataSource {
  Client client;

  TransactionRemoteDataSource({required this.client});

  @override
  Future addTransaction({
    required String authKey,
    required int paymentType,
    required String sourceId,
    required String departmentId,
    required String employeeId,
    required String employeeType,
    required String sum,
  }) async {
    final Response response = await client.post(
        Uri.https('edison.group', '/cstest/hs/bookkeeping/pays'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $authKey'
        },
        body:
            '{"paymentType":$paymentType,"sourceId":"$sourceId","departmentId":"$departmentId","employeeType":"engeneer","employeeId":"$employeeId","sum":"$sum"}'); //engenee, postman, employee

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions(
      {int page = 0,
      required String authKey,
      required String startDate,
      required String endDate,
      required String filters}) async {
    final Response response = await client.get(
      Uri.https('edison.group',
          '/cstest/hs/bookkeeping/pays?page=$page&start_date=$startDate&end_date=$endDate&filters=$filters'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $authKey'
      },
    );

    if (response.statusCode == 200) {
      final List body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw ServerException();
  }
}
