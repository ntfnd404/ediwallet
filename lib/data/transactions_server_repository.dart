import 'dart:async';
import 'dart:convert';
import 'package:ediwallet/common/parser.dart' as parser;
import 'package:ediwallet/common/http_service.dart' as http_service;
import 'package:ediwallet/models/transaction.dart';

Future _fetchFromServer(
    DateTime startDate, DateTime endDate, int firstPage) async {
  final responce = await http_service.fetchFromServer('bookkeeping/pays',
      '{"FirstPage":"${firstPage.toString()}","StartDate":"${startDate.toString()}","EndDate":"${endDate.toString()}"}');

  if (responce.statusCode == 200) {
    final apiItems = parser.transactions(utf8.decode(responce.bodyBytes));
    return apiItems;
  }
}

class Transactions {
  bool hasMore;
  bool _isLoading;
  List<Transaction> _data;
  Stream<List<Transaction>> stream;
  StreamController<List<Transaction>> _controller;

  DateTime startDate;
  DateTime endDate;

  Transactions(this.startDate, this.endDate) {
    hasMore = true;
    _isLoading = false;
    _data = [];
    _controller = StreamController<List<Transaction>>.broadcast();
    stream = _controller.stream.map((List<Transaction> transactionsData) {
      return transactionsData.map((Transaction transactionData) {
        return transactionData;
        // return Transaction.fromJson(transactionData);
      }).toList();
    });
    refresh(startDate, endDate);
  }

  Future<void> refresh(DateTime startDate, DateTime endDate) =>
      loadMore(clearCashedData: true, startDate: startDate, endDate: endDate);

  Future<void> loadMore(
      {bool clearCashedData = false, DateTime startDate, DateTime endDate}) {
    if (clearCashedData) {
      hasMore = true;
      _data.clear();
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;
    return _fetchFromServer(startDate, endDate, _data.length)
        .then((dynamic transactionsData) {
      _isLoading = false;
      if (transactionsData != null) {
        _data.addAll(transactionsData as List<Transaction>);
        // hasMore = (_data.length < 30);
        // hasMore = (_data.length > 0);
        hasMore = transactionsData.length as int > 0;
        _controller.add(_data);
      } else {
        return Future.value();
      }
    });
  }
}
