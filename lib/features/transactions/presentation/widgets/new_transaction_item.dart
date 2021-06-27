import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionAddItem extends StatelessWidget {
  const TransactionAddItem(this.page, this.labelText, this.hintText,
      {Key? key, this.keyboardType, this.textInputAction, this.inputFormatters})
      : super(key: key);

  final Widget page;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => page,
                  ),
                );
                debugPrint(result.toString());
              },
            ),
          ),
          onTap: () => Navigator.push<MaterialPageRoute>(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              )),
    );
  }
}
