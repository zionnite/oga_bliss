import 'package:flutter/material.dart';

import '../util/currency_formatter.dart';

class transactionWidget extends StatelessWidget {
  transactionWidget({
    required this.leadingIcon,
    required this.amount,
    required this.date,
    this.trailingIcon,
  });

  final Icon leadingIcon;
  final String amount;
  final String date;
  final Icon? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: leadingIcon,
              title: Text(
                CurrencyFormatter.getCurrencyFormatter(
                  amount: "${amount}",
                ),
              ),
              subtitle: Text(date),
              trailing: trailingIcon,
            )
          ],
        ),
      ),
    );
  }
}
