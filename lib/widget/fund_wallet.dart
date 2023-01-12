import 'package:flutter/material.dart';
import 'package:oga_bliss/widget/small_btn.dart';

import '../util/currency_formatter.dart';

class fundWallet extends StatelessWidget {
  fundWallet({
    required this.image_name,
    required this.name,
    required this.time,
    required this.amount,
    required this.onTap,
  });

  final String image_name;
  final String name;
  final String time;
  final String amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      image_name,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Time: ${time}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          CurrencyFormatter.getCurrencyFormatter(
                            amount: "${amount}",
                          ),
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                smallBtn(
                  btnName: 'Pull Out',
                  btnColor: Colors.black,
                  onTap: () {
                    print('pull out');
                  },
                ),
                smallBtn(
                  btnName: 'Settled Aready',
                  btnColor: Colors.green,
                  onTap: () {
                    print('Settled out');
                  },
                ),
                smallBtn(
                  btnName: 'Already Pull out',
                  btnColor: Colors.red,
                  onTap: () {
                    print('pull out');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
