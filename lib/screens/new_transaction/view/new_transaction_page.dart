import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ediwallet/screens/dds/view/dds_list_page.dart';
import 'package:ediwallet/screens/new_transaction/widgets/new_transaction_item.dart';

enum PaymentType { lafayette, jefferson, terminal }

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({Key? key}) : super(key: key);

  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage> {
  String dropdownValue = 'One';

  PaymentType? _paymentType = PaymentType.lafayette;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final messenger = ScaffoldMessenger.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Новая операция'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ListTile(
                        title: const Text('Наличные'),
                        leading: Radio(
                            value: PaymentType.lafayette,
                            groupValue: _paymentType,
                            onChanged: (PaymentType? value) {
                              setState(() => _paymentType = value);
                            }),
                      ),
                      ListTile(
                        title: const Text('Безналично'),
                        leading: Radio<PaymentType>(
                          value: PaymentType.jefferson,
                          groupValue: _paymentType,
                          onChanged: (PaymentType? value) {
                            setState(() {
                              _paymentType = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Терминал'),
                        leading: Radio<PaymentType>(
                          value: PaymentType.terminal,
                          groupValue: _paymentType,
                          onChanged: (PaymentType? value) {
                            setState(() {
                              _paymentType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const TransactionAddItem(
                      DDSListPage(), 'Тип оплаты', 'Выберете тип оплаты'),
                  const TransactionAddItem(
                      DDSListPage(), 'ДДС', 'Выберете ДДС'),
                  const TransactionAddItem(
                      DDSListPage(), 'Отдел', 'Выберете отдел'),
                  TransactionAddItem(
                      const DDSListPage(), 'Сумма', 'Введите сумму',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Сохранить'),
                      ),
                    ),
                  )
                ],
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
