import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ediwallet/common/widgets/bottom_loader.dart';
import 'package:ediwallet/common/bloc/scroll_event.dart';
import 'package:ediwallet/common/bloc/scroll_state.dart';
import 'package:ediwallet/dds/bloc/dds_bloc.dart';
import 'package:ediwallet/dds/models/dds.dart';
import 'package:ediwallet/dds/widgets/dds_list_item.dart';

class DDSList extends StatefulWidget {
  const DDSList({Key? key}) : super(key: key);

  @override
  _DDSListState createState() => _DDSListState();
}

class _DDSListState extends State {
  final _scrollController = ScrollController();
  late DDSBloc _ddsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _ddsBloc = context.read<DDSBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DDSBloc, ScrollState<DDS>>(
      builder: (context, state) {
        switch (state.status) {
          case StateStatus.failure:
            return const Center(child: Text('Ошибка подключения к серверу'));
          case StateStatus.success:
            if (state.items.isEmpty) {
              return const Center(child: Text('Нет новых элементов списка'));
            }
            return RefreshIndicator(
              onRefresh: () => _onRefresh(),
              child: ListView.separated(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.hasReachedMax
                    ? state.items.length
                    : state.items.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.items.length
                      ? BottomLoader()
                      : DDSListItem(dds: state.items[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black,
                  );
                },
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _ddsBloc.add(ScrollEvent(isRefresh: true));
  }

  void _onScroll() {
    if (_isBottom) _ddsBloc.add(ScrollEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
