import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMoneyField extends StatefulWidget {
  MyMoneyField({
    required this.myTextFormController,
    required this.fieldName,
    this.onChange,
    this.prefix,
    this.suffix,
    this.hintText,
  });

  final TextEditingController myTextFormController;
  final String fieldName;
  final ValueChanged<String>? onChange;
  final IconData? prefix;
  final IconData? suffix;
  final String? hintText;

  @override
  State<MyMoneyField> createState() => _MyMoneyFieldState();
}

class _MyMoneyFieldState extends State<MyMoneyField> {
  final String NGN = cSymbol("NGN");
  static const _locale = 'en';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: widget.onChange,
        controller: widget.myTextFormController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          labelText: widget.fieldName,
          hintText: widget.hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 15, left: 18.0),
            child: Text(
              NGN,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
        maxLength: 20,
      ),
    );
  }
}
