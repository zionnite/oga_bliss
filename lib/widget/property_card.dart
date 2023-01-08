import 'package:flutter/material.dart';

import '../util/currency_formatter.dart';

class propertyCard extends StatelessWidget {
  const propertyCard({
    required this.bgColor1,
    required this.bgColor2,
    required this.title,
    required this.value,
    required this.icon,
    this.isNaira = true,
  });

  final Color bgColor1;
  final Color bgColor2;
  final String title;
  final String value;
  final Icon icon;
  final bool? isNaira;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgColor1, bgColor2],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontFamily: 'Passion One',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: (isNaira!)
                          ? Text(
                              CurrencyFormatter.getCurrencyFormatter(
                                amount: value,
                              ),
                              style: const TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontFamily: 'BlackOpsOne',
                              ),
                            )
                          : Text(
                              value,
                              style: const TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontFamily: 'BlackOpsOne',
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
