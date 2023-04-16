import 'package:currency_symbols/currency_symbols.dart';
import 'package:simple_currency_format/simple_currency_format.dart';

class CurrencyFormatter {
  static getCurrencyFormatter({required String amount}) {
    final String NGN = cSymbol("NGN");
    if (amount.toString() == null ||
        amount.toString() == '' ||
        amount.toString() == 'false') {
      return '$NGN' +
          currencyFormat(int.parse('0'), locale: 'en_US', symbol: "");
    } else {
      return '$NGN' +
          currencyFormat(int.parse(amount), locale: 'en_US', symbol: "");
    }
  }
}
