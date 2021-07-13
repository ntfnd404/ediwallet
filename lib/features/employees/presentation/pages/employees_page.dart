import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/bottom_loader.dart';
import '../bloc/employees_cubit.dart';
import '../bloc/employees_state.dart';

class EmployeesListPage extends StatefulWidget {
  final String employeeType;

  const EmployeesListPage({Key? key, required this.employeeType})
      : super(key: key);

  @override
  // TODO: пересмотреть механизм передачи employeeType через конструктор
  // ignore: no_logic_in_create_state
  _EmployeesPageState createState() => _EmployeesPageState(employeeType);
}

class _EmployeesPageState extends State {
  final String employeeType;
  final _scrollController = ScrollController();

  _EmployeesPageState(this.employeeType);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сотрудники')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<EmployeesCubit, BaseState>(
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
              if (state is EmployeesListSuccessState) {
                // if (state.items.isEmpty) {
                // TODO: позволяем билдеру отрисовать кешированные записи. но увндомдяем снак баром
                // showSnakBar(context, 'Отсутсвуют транзакции');
                //   return const Center(child: Text('Отсутсвуют транзакции'));
                // }
                return RefreshIndicator(
                  onRefresh: () async =>
                      BlocProvider.of<EmployeesCubit>(context).getItems(
                          isRefresh: true, employeeType: employeeType),
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
                              title: Text(
                                state.items[index].name
                                    .replaceAll('', '\u{200B}'),
                                style: const TextStyle(fontSize: 18.0),
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<EmployeesCubit>(context)
          .getItems(employeeType: employeeType);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
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
