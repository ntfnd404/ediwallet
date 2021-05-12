import 'package:ediwallet/blocs/accountancy_cubit/accountancy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ediwallet/blocs/filters_list_bloc/filters_list_bloc.dart';

class FiltersList extends StatelessWidget {
  // late TypeOfPaymentSetings _paymentSettings = TypeOfPaymentSetings();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersListBloc, FiltersState>(
      builder: (context, state) {
        return SizedBox(
          height: 50.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.items.length,
              itemBuilder: (context, int index) {
                return Container(
                  margin:
                      const EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
                  child: FilterChip(
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
                        BlocProvider.of<FiltersListBloc>(context).add(
                            FiltersEvent(index: index, selected: selected));
                        BlocProvider.of<AccountancyCubit>(context).fetchItems();
                        // _paymentSettings.showTypePaymentBottomSheet(context);
                      }
                    },
                  ),
                );
              }),
        );
      },
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
