import 'package:currency_symbols/currency_symbols.dart';
import 'package:flutter/material.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

class CurrencyFormatter {
  static getCurrencyFormatter({required String amount}) {
    final String NGN = cSymbol("NGN");
    return '$NGN ' +
        currencyFormat(int.parse(amount), locale: 'en_US', symbol: "");
  }
}
