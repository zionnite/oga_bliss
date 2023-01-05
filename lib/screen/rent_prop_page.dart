import 'package:flutter/material.dart';

class RentPropertyPage extends StatefulWidget {
  const RentPropertyPage({Key? key}) : super(key: key);

  @override
  State<RentPropertyPage> createState() => _RentPropertyPageState();
}

class _RentPropertyPageState extends State<RentPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Rent Page',
      style: TextStyle(fontSize: 55),
    );
  }
}
