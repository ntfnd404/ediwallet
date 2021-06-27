import 'dart:convert';

import 'package:ediwallet/core/error/exception.dart';
import 'package:ediwallet/features/dds/data/models/dds_model.dart';
import 'package:http/http.dart';

abstract class DDSRemoteDataSource {
  Future<List<DDSModel>> getAllDDS({int page = 0, required String authKey});
}

class DDSRemoteDataSourceImpl implements DDSRemoteDataSource {
  Client client;

  DDSRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DDSModel>> getAllDDS(
      {int page = 0, required String authKey}) async {
    final Response response = await client.get(
      Uri.https('edison.group', '/cstest/hs/bookkeeping/dds?page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $authKey'
      },
    );

    if (response.statusCode == 200) {
      return (json.decode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => DDSModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw ServerException();
  }
}
