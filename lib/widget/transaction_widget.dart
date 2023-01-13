import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    return SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      child: Slidable(
        startActionPane: const ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: null,
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),
        child: Card(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
          ),
          child: Container(
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
        ),
      ),
    );
  }
}
