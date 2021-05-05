import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

// import 'package:ediwallet/bloc_common/base_repository.dart';

import 'package:ediwallet/common/bloc/scroll_event.dart';
import 'package:ediwallet/common/bloc/scroll_state.dart';
import 'package:ediwallet/dds/models/dds.dart';

class DDSBloc extends Bloc<Event, ScrollState<DDS>> {
  DDSBloc({required this.httpClient}) : super(ScrollState());

  final http.Client httpClient;
  // final BaseRepository repository;

  @override
  Stream<Transition<Event, ScrollState<DDS>>> transformEvents(
    Stream<Event> events,
    TransitionFunction<Event, ScrollState<DDS>> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ScrollState<DDS>> mapEventToState(Event event) async* {
    if (event is ScrollEvent) {
      yield await _mapDDSFetchedToState(
          event.isRefresh ? ScrollState<DDS>() : state);
    }
  }

  Future<ScrollState<DDS>> _mapDDSFetchedToState(ScrollState<DDS> state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == StateStatus.initial) {
        final items = await _fetchItems();
        return state.copyWith(
          status: StateStatus.success,
          items: items,
          hasReachedMax: items.length < 30 || false,
        );
      }
      final items = await _fetchItems(state.items.length);
      // final items = await repository.fetchItems(state.items.length);
      return items.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: StateStatus.success,
              items: List.of(state.items)..addAll(items),
              hasReachedMax: items.length < 30 || false,
            );
    } on Exception {
      return state.copyWith(status: StateStatus.failure);
    }
  }

  Future<List<DDS>> _fetchItems([int startIndex = 0]) async {
    // return repository.fetchItems(state.items.length);

    final response = await httpClient.get(
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
