import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../di_container.dart';
import '../../../dds/domain/entities/dds_entity.dart';
import '../../../dds/presentation/pages/dds_list_page.dart';
import '../../../deparments/domain/entities/department_entity.dart';
import '../../../deparments/presentation/pages/departments_list_page.dart';
import '../bloc/transaction_add_cubit.dart';
import '../bloc/transaction_add_state.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  // String dropdownValue = 'One';
  late TextEditingController _departmentController;
  late TextEditingController _sourceController;
  late TextEditingController _sumController;

  @override
  void initState() {
    super.initState();
    _departmentController = TextEditingController();
    _sourceController = TextEditingController();
    _sumController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // final messenger = ScaffoldMessenger.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Новая транзакция'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.all(12.0),
            child: BlocProvider(
              create: (context) => sl<TransactionsAddCubit>(),
              child: BlocBuilder<TransactionsAddCubit, BaseState>(
                builder: (context, state) {
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        title: const Text('Наличные'),
                        leading: Radio(
                            value: 0,
                            groupValue: state is TransactionFillState
                                ? state.paymentType
                                : 0,
                            onChanged: (int? value) async {
                              BlocProvider.of<TransactionsAddCubit>(context)
                                  .inputPaymentType(paymentType: value!);
                            }),
                      ),
                      ListTile(
                        title: const Text('Терминал'),
                        leading: Radio(
                          value: 1,
                          groupValue: state is TransactionFillState
                              ? state.paymentType
                              : 0,
                          onChanged: (int? value) async {
                            BlocProvider.of<TransactionsAddCubit>(context)
                                .inputPaymentType(paymentType: value!);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Безналично'),
                        leading: Radio(
                          value: 2,
                          groupValue: state is TransactionFillState
                              ? state.paymentType
                              : 0,
                          onChanged: (int? value) async {
                            BlocProvider.of<TransactionsAddCubit>(context)
                                .inputPaymentType(paymentType: value!);
                          },
                        ),
                      ),
                      // const TransactionAddItem(
                      //     DDSListPage(), 'Тип оплаты', 'Выберете тип оплаты'),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                            controller: _sourceController,
                            decoration: InputDecoration(
                              labelText: "ДДС",
                              hintText: "Выберете ДДС",
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {},
                              ),
                            ),
                            onTap: () async {
                              final DDS? ddsItem =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DDSListPage(),
                                ),
                              );
                              if (ddsItem != null) {
                                _sourceController.text = ddsItem.name;
                                BlocProvider.of<TransactionsAddCubit>(context)
                                    .inputValueToField(
                                        id: ddsItem.id,
                                        name: ddsItem.name,
                                        field: 'source');
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                            controller: _departmentController,
                            decoration: InputDecoration(
                              labelText: "Отдел",
                              hintText: "Выберете отдел",
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {},
                              ),
                            ),
                            onTap: () async {
                              final Department? _departmentItem =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DepartmentsListPage(),
                                ),
                              );
                              if (_departmentItem != null) {
                                _departmentController.text =
                                    _departmentItem.name;
                                BlocProvider.of<TransactionsAddCubit>(context)
                                    .inputValueToField(
                                        id: _departmentItem.id,
                                        name: _departmentItem.name,
                                        field: 'deparment');
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: _sumController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Сумма",
                            hintText: "Введите сумму",
                            border: const OutlineInputBorder(),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      // TransactionAddItem(
                      //     const DDSListPage(), 'Сумма', 'Введите сумму',
                      //     keyboardType: TextInputType.number,
                      //     textInputAction: TextInputAction.done,
                      //     inputFormatters: <TextInputFormatter>[
                      //       FilteringTextInputFormatter.digitsOnly
                      //     ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<TransactionsAddCubit>(context)
                                  .createTransaction(_sumController.text);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Сохранить'),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: SizedBox(
//                         width: double.infinity,
//                         child: DropdownButton<String>(
//                           value: dropdownValue,
//                           icon: const Icon(Icons.arrow_drop_down),
//                           // iconSize: 24.0,
//                           elevation: 16,
//                           style: const TextStyle(color: Colors.deepPurple),
//                           // underline: Container(
//                           //   height: 2,
//                           //   color: Colors.deepPurpleAccent,
//                           // ),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               dropdownValue = newValue!;
//                             });
//                           },
//                           items: <String>['One', 'Two', 'Free', 'Four']
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
