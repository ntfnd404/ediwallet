import 'package:ediwallet/models/Transaction.dart';
import 'dart:convert';

List<Transaction> transactions(dynamic body) {
  List<dynamic> parsed = json.decode(body);
  return parsed.map((json) => Transaction.fromJson(json)).toList();

//   List<Fruit> decodeFruit(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<Fruit>((json) => Fruit.fromMap(json)).toList();
// }
}
