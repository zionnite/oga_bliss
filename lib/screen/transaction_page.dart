import 'package:flutter/material.dart';

import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/transaction_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Transactions'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NoticeMe(
                    title: 'Oops!',
                    desc: 'Your bank account is not yet verify!',
                    icon: Icons.warning,
                    icon_color: Colors.red,
                    border_color: Colors.red,
                    btnTitle: 'Verify Now',
                    btnColor: Colors.blue,
                    onTap: () {},
                  ),
                  transactionWidget(
                    leadingIcon: const Icon(
                      Icons.trending_up,
                      color: Colors.green,
                    ),
                    amount: '20000',
                    date: 'June 3rd 1994',
                    trailingIcon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.red,
                    ),
                  ),
                  transactionWidget(
                    leadingIcon: const Icon(
                      Icons.trending_up,
                      color: Colors.green,
                    ),
                    amount: '20000',
                    date: 'June 3rd 1994',
                    trailingIcon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
