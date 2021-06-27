import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exception.dart';
import '../models/departmet_model.dart';

abstract class DepartmentsRemoteDataSource {
  Future<List<DepartmentModel>> getDepartments({required String authKey});
}

class DepartmentsRemoteDataSourceImpl implements DepartmentsRemoteDataSource {
  Client client;

  DepartmentsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DepartmentModel>> getDepartments(
      {required String authKey}) async {
    final Response response = await client.get(
      Uri.https('edison.group', '/cstest/hs/bookkeeping/departments'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $authKey'
      },
    );

    if (response.statusCode == 200) {
      final List body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body
          .map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw ServerException();
  }
}
