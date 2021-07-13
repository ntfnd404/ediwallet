import 'package:ediwallet/features/transactions/presentation/bloc/transactions_cubit/transaction_add_cubit.dart';
import 'package:ediwallet/features/transactions/presentation/bloc/transactions_cubit/transaction_add_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../di_container.dart';
import '../../../dds/domain/entities/dds_entity.dart';
import '../../../dds/presentation/pages/dds_list_page.dart';
import '../../../departments/domain/entities/department_entity.dart';
import '../../../departments/presentation/pages/departments_list_page.dart';
import '../../../employees/domain/entities/employee_entity.dart';
import '../../../employees/presentation/bloc/employees_cubit.dart';
import '../../../employees/presentation/pages/employees_page.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  // String dropdownValue = 'One';
  late TextEditingController _departmentController;
  late TextEditingController _sourceController;
  late TextEditingController _employeeController;
  late TextEditingController _sumController;

  @override
  void initState() {
    super.initState();
    _departmentController = TextEditingController();
    _sourceController = TextEditingController();
    _employeeController = TextEditingController();
    _sumController = TextEditingController();
  }

  @override
  void dispose() {
    _departmentController.dispose();
    _sourceController.dispose();
    _employeeController.dispose();
    _sumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                BlocProvider<TransactionsAddCubit>(
                  create: (context) => sl<TransactionsAddCubit>(),
                  child: BlocBuilder<TransactionsAddCubit, BaseState>(
                    builder: (context, state) {
                      return Column(
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
                                    BlocProvider.of<TransactionsAddCubit>(
                                            context)
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
                                    BlocProvider.of<TransactionsAddCubit>(
                                            context)
                                        .inputValueToField(
                                            id: _departmentItem.id,
                                            name: _departmentItem.name,
                                            field: 'deparment');
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 2, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.black26)),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: state is InitialState
                                    ? 'Инженеры'
                                    : (state as TransactionFillState)
                                        .employeeType,
                                iconSize: 42,
                                style: const TextStyle(color: Colors.black54),
                                underline: const SizedBox(),
                                items: <String>[
                                  'Инженеры',
                                  'Расклейщики',
                                  'Офисные сотрудники'
                                ].map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newWalue) {
                                  BlocProvider.of<TransactionsAddCubit>(context)
                                      .inputValueToField(
                                          employeeType: newWalue,
                                          field: 'employeeType');
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                                controller: _employeeController,
                                decoration: InputDecoration(
                                  labelText: "Сотрудник",
                                  hintText: "Выберете сотрудника",
                                  border: const OutlineInputBorder(),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {},
                                  ),
                                ),
                                onTap: () async {
                                  final Employee? _eployeeItem =
                                      await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BlocProvider<EmployeesCubit>(
                                        // lazy: true,
                                        create: (context) =>
                                            sl<EmployeesCubit>()..getItems(),
                                        child: EmployeesListPage(
                                            employeeType: state is InitialState
                                                ? 'Инженеры'
                                                : (state
                                                        as TransactionFillState)
                                                    .employeeType),
                                      ),
                                    ),
                                  );
                                  if (_eployeeItem != null) {
                                    _employeeController.text =
                                        _eployeeItem.name;
                                    BlocProvider.of<TransactionsAddCubit>(
                                            context)
                                        .inputValueToField(
                                            id: _eployeeItem.id,
                                            name: _eployeeItem.name,
                                            field: 'employee');
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final bool result = await BlocProvider.of<
                                          TransactionsAddCubit>(context)
                                      .createTransaction(_sumController.text);
                                  if (result) {
                                    Navigator.of(context).pop();
                                  } else {
                                    showSnakBar(context,
                                        'Ошибка создания транзакции. Попробуйте еще раз');
                                  }
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
              ],
            ),
          ),
        ),
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
  Future.delayed(const Duration(seconds: 2));
  // ScaffoldMessenger.of(context).hideCurrentSnackBar();
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


// showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(30.0),
//           child: SafeArea(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(30.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   _createTile(context, 'Наличные', Icons.ac_unit, _action1),
//                   _createTile(
//                       context, 'Безналичные', Icons.colorize_sharp, _action2),
//                   _createTile(
//                       context, 'Терминал', Icons.mobile_friendly, _action3),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
