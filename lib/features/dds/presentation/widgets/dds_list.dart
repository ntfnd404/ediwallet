import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/bottom_loader.dart';
import '../../domain/entities/dds_entity.dart';
import '../bloc/dds_cubit.dart';

class DDSList extends StatefulWidget {
  const DDSList({Key? key}) : super(key: key);

  @override
  _DDSListState createState() => _DDSListState();
}

class _DDSListState extends State {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DDSCubit, BaseState>(
      listener: (context, state) {
        if (state is FailureState) {
          // TODO: показываем блокирующий виджет с ошибкой но позволяем билдеру отрисовать кешированные записи
          // return const Center(child: Text('Ошибка подключения к серверу'));
        } else if (state is NoInternetConnectionState) {
          // TODO: Показать виджет с кнопкой перезапросить с сервера из-за отстусвия интернета и позволяем билдеру отрисовать кешированные записи
          showSnakBar(context, 'Нет соединения с интернетом');
        }
      },
      builder: (context, state) {
        if (state is ItemsListSuccessState<DDS>) {
          // if (state.items.isEmpty) {
          // TODO: позволяем билдеру отрисовать кешированные записи. но увндомдяем снак баром
          // showSnakBar(context, 'Отсутсвуют транзакции');
          //   return const Center(child: Text('Отсутсвуют транзакции'));
          // }
          return RefreshIndicator(
            onRefresh: () => _onRefresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(10.0),
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              // itemExtent: 94.0,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.black,
                );
              },
              itemCount: state.hasReachedMax
                  ? state.items.length
                  : state.items.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.items.length
                    ? BottomLoader()
                    : ListTile(
                        leading: state.items[index].isComing
                            ? const Icon(
                                Icons.add,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.remove,
                                color: Colors.red,
                              ),
                        title: Text(
                          state.items[index].name.replaceAll('', '\u{200B}'),
                          style: const TextStyle(fontSize: 18.0),
                          // overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () =>
                            Navigator.of(context).pop(state.items[index]),
                      );
              },
            ),
          );
        } else if (state is LoadingState || state is InitialState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Произошла ошибка'));
        }
      },
    );

    // return BlocBuilder<DDSCubit, BaseState>(
    //   builder: (context, state) {
    //     switch (state.status) {
    //       case StateStatus.failure:
    //         return const Center(child: Text('Ошибка подключения к серверу'));
    //       case StateStatus.success:
    //         if (state.items.isEmpty) {
    //           return const Center(child: Text('Нет новых элементов списка'));
    //         }
    //         return RefreshIndicator(
    //           onRefresh: () => _onRefresh(),
    //           child: ListView.separated(
    //             controller: _scrollController,
    //             physics: const AlwaysScrollableScrollPhysics(),
    //             itemCount: state.hasReachedMax
    //                 ? state.items.length
    //                 : state.items.length + 1,
    //             itemBuilder: (BuildContext context, int index) {
    //               return index >= state.items.length
    //                   ? BottomLoader()
    //                   : DDSListItem(dds: state.items[index]);
    //             },
    //             separatorBuilder: (BuildContext context, int index) {
    //               return const Divider(
    //                 color: Colors.black,
    //               );
    //             },
    //           ),
    //         );
    //       default:
    //         return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // BlocProvider.of<DDSBloc>(context).add(ScrollEvent(isRefresh: true));
    BlocProvider.of<DDSCubit>(context).getDDSItems(isRefresh: true);
  }

  void _onScroll() {
    if (_isBottom) {
      // BlocProvider.of<DDSBloc>(context).add(ScrollEvent());
      BlocProvider.of<DDSCubit>(context).getDDSItems();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    // final maxScroll = _scrollController.position.maxScrollExtent;
    // final currentScroll = _scrollController.offset;
    // return currentScroll >= (maxScroll * 0.9);
    return _scrollController.position.maxScrollExtent ==
        _scrollController.offset;
  }

  void showSnakBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
    Future.delayed(const Duration(seconds: 2));
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
