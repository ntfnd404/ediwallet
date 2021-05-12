import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ediwallet/repositories/base_repository.dart';
import 'package:ediwallet/models/dds.dart';

class DDSRepository implements BaseRepository {
  @override
  Future<List<DDS>> fetchItems([int startIndex = 0]) async {
    final response = await http.get(
      Uri.https('edison.group', '/cstest/hs/bookkeeping/dds/$startIndex'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Basic bnRmbmQ6dmZuYmttbGY='
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(utf8.decode(response.bodyBytes)) as List;
      return body.map((dynamic json) {
        return DDS(
          id: json['id'] as String,
          name: json['name'] as String,
          isComing: json['is_coming'] == 1 || false,
        );
      }).toList();
    }

    throw Exception('Ошибка подключения к серверу');
  }
}
