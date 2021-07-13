import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../di_container.dart';
import '../../../accountancy/presentation/bloc/accountancy_cubit.dart';
import '../bloc/date_range_cubit/date_range_cubit.dart';
import '../bloc/transactions_cubit/transactions_list_cubit.dart';

class DateRangeWidget extends StatelessWidget {
  const DateRangeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DateRangeCubit>()..getDateTime(),
      child: BlocBuilder<DateRangeCubit, DateRangeState>(
        builder: (context, state) {
          return TextButton.icon(
            onPressed: () async {
              final DateTimeRange? pikedDate = await showDateRangePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
                initialDateRange:
                    DateTimeRange(start: state.firstDate, end: state.lastDate),
              );
              if (pikedDate != null) {
                if (pikedDate.start != state.firstDate ||
                    pikedDate.end != state.lastDate) {
                  BlocProvider.of<DateRangeCubit>(context).setDateTime(
                      firstDate: pikedDate.start, lastDate: pikedDate.end);
                  BlocProvider.of<AccountancyCubit>(context).fetchItems();
                  BlocProvider.of<TransactionsListCubit>(context)
                      .getTransactions(isRefresh: true);
                }
              }
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.white,
            ),
            label: Text(
              "${DateFormat('dd.MM.yyyy').format(state.firstDate)} - ${DateFormat('dd.MM.yyyy').format(state.lastDate)}",
              style: const TextStyle(fontSize: 16.0),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          );
        },
      ),
    );
  }
}
