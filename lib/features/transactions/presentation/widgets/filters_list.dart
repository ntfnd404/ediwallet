import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../di_container.dart';
import '../../../accountancy/presentation/bloc/accountancy_cubit.dart';
import '../bloc/filters_list_bloc/filters_cubit.dart';
import '../bloc/filters_list_bloc/filters_state.dart';
import '../bloc/transactions_cubit/transactions_list_cubit.dart';
import 'payment_bottom_sheet.dart';

class FiltersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FiltersCubit>(),
      child: BlocBuilder<FiltersCubit, BaseState>(
        builder: (context, state) {
          if (state is FiltersState) {
            return SizedBox(
              height: 50.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.items.length,
                  itemBuilder: (context, int index) {
                    return Container(
                        margin: const EdgeInsets.only(
                            left: 5.0, top: 10.0, right: 5.0),
                        child: index < 2
                            ? FilterChip(
                                selected: state.items[index].isSelected,
                                disabledColor: Theme.of(context).primaryColor,
                                label: Text(state.items[index].name),
                                onSelected: (bool selected) {
                                  if (index == 0 &&
                                      selected == false &&
                                      state.items[1].isSelected == false) {
                                    showSnakBar(context,
                                        'Один из фильтров вида поступления должен быть выбран');
                                  } else if (index == 1 &&
                                      selected == false &&
                                      state.items[0].isSelected == false) {
                                    showSnakBar(context,
                                        'Один из фильтров вида поступления должен быть выбран');
                                  } else {
                                    BlocProvider.of<FiltersCubit>(context)
                                        .setFilter(
                                            index: index,
                                            name: state.items[index].name,
                                            value: selected);
                                    BlocProvider.of<AccountancyCubit>(context)
                                        .fetchItems();
                                    BlocProvider.of<TransactionsListCubit>(
                                            context)
                                        .getTransactions(isRefresh: true);
                                  }
                                },
                              )
                            : InputChip(
                                label: const Text('test'),
                                selected: state.items[index].isSelected,
                                onDeleted: () {
                                  BlocProvider.of<FiltersCubit>(context)
                                      .clearFilter(
                                          index: index,
                                          name: state.items[index].name);
                                },
                                onSelected: (bool selected) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return PaymentBottomSheet(
                                          callback: (int? intput) {
                                            if (intput != null) {
                                              BlocProvider.of<FiltersCubit>(
                                                      context)
                                                  .setFilter(
                                                      index: index,
                                                      name: state
                                                          .items[index].name,
                                                      value: selected);
                                              BlocProvider.of<AccountancyCubit>(
                                                      context)
                                                  .fetchItems();
                                              BlocProvider.of<
                                                          TransactionsListCubit>(
                                                      context)
                                                  .getTransactions(
                                                      isRefresh: true);
                                            }
                                          },
                                        );
                                      });
                                },
                              ));
                  }),
            );
          } else {
            return const Center(child: Text('Произошла ошибка'));
          }
        },
      ),
    );
  }
}

void showSnakBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
  Future.delayed(const Duration(seconds: 2))
      .then((value) => ScaffoldMessenger.of(context).hideCurrentSnackBar());
}
