import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exception.dart';
import '../models/employee_model.dart';

abstract class IEmployeesRemoteDataSource {
  Future<List<EmployeeModel>> getList(
      {int page = 0, required String employeeType, required String authKey});
}

class EmployeesRemoteDataSource implements IEmployeesRemoteDataSource {
  Client client;

  EmployeesRemoteDataSource({required this.client});

  @override
  Future<List<EmployeeModel>> getList(
      {int page = 0,
      required String employeeType,
      required String authKey}) async {
    final Response response = await client.get(
      Uri.https('edison.group',
          '/cstest/hs/bookkeeping/employees?employeeType=$employeeType&page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $authKey'
      },
    );

    if (response.statusCode == 200) {
      final List body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body
          .map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw ServerException();
  }
}
