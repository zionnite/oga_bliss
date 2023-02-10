import 'package:flutter/material.dart';

class VerifyBank extends StatefulWidget {
  const VerifyBank({Key? key}) : super(key: key);

  @override
  State<VerifyBank> createState() => _VerifyBankState();
}

class _VerifyBankState extends State<VerifyBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Very Bank Account'),
      ),
      body: Container(),
    );
  }
}
