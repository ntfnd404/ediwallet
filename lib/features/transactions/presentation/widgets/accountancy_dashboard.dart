import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../accountancy/presentation/bloc/accountancy_cubit.dart';

class AccountancyDashboard extends StatelessWidget {
  const AccountancyDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      // TODO: переделать на FutureBuilder внутри BlocBuilder
      child: BlocBuilder<AccountancyCubit, AccountancySucces>(
        builder: (context, item) {
          return Column(
            children: [
              AccountancyItem(label: 'Поступления', sum: item.income),
              const AccountancyDivider(),
              AccountancyItem(label: 'Расходы', sum: item.outcome),
              const AccountancyDivider(),
              AccountancyItem(label: 'Касса', sum: item.cash),
              const AccountancyDivider(),
              AccountancyItem(label: 'Задолженность', sum: item.debt),
              const AccountancyDivider(),
              AccountancyItem(label: 'Баланс', sum: item.balance),
            ],
          );
        },
      ),
    );
  }
}

class AccountancyItem extends StatelessWidget {
  final String sum;
  final String label;
  const AccountancyItem({
    Key? key,
    required this.label,
    required this.sum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        Text(
          sum,
          style: const TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ],
    );
  }
}

class AccountancyDivider extends StatelessWidget {
  const AccountancyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
    );
  }
}
