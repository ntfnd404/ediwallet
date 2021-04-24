import 'dart:convert';
import 'package:ediwallet/models/transaction.dart';

List<Transaction> transactions(String body) {
  final dynamic parsed = json.decode(body);
  return (parsed as List<dynamic>)
      .map((dynamic json) => Transaction.fromJson(json as Map<String, dynamic>))
      .toList();

//   List<Fruit> decodeFruit(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Fruit>((json) => Fruit.fromMap(json)).toList();
// }
}
