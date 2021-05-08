import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filters_event.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filters_state.dart';
import 'package:ediwallet/screens/transaction_home_page/widgets/filters_list/bloc/filtes_list_bloc.dart';

class FiltersList extends StatefulWidget {
  const FiltersList({Key? key}) : super(key: key);

  @override
  _FiltersListState createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  // late TypeOfPaymentSetings _paymentSettings;

  @override
  void initState() {
    super.initState();
    // _paymentSettings = TypeOfPaymentSetings();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersListBloc, FiltersState>(
        // bloc: FiltersListBloc(),
        builder: (BuildContext context, state) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(left: 5.0, top: 10.0, right: 5.0),
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
                    // BlocProvider.of<FiltersListBloc>(context)
                    //     .add(FiltersEvent(index: index));

                    setState(() => BlocProvider.of<FiltersListBloc>(context)
                        .add(FiltersEvent(index: index)));
                    // _paymentSettings.showTypePaymentBottomSheet(context);
                  }
                },
              ),
            );
          });
    });
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
