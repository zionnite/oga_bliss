import 'package:flutter/material.dart';

class BuyPropertyPage extends StatefulWidget {
  const BuyPropertyPage({Key? key}) : super(key: key);

  @override
  State<BuyPropertyPage> createState() => _BuyPropertyPageState();
}

class _BuyPropertyPageState extends State<BuyPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Buy Page',
      style: TextStyle(fontSize: 55),
    );
  }
}
