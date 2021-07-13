import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exception.dart';
import '../models/dds_model.dart';

abstract class IDDSRemoteDataSource {
  Future<List<DDSModel>> getDDS({int page = 0, required String authKey});
}

class DDSRemoteDataSource implements IDDSRemoteDataSource {
  Client client;

  DDSRemoteDataSource({required this.client});

  @override
  Future<List<DDSModel>> getDDS({int page = 0, required String authKey}) async {
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
