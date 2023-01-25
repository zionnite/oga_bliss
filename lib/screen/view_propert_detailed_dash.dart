import 'package:flutter/material.dart';

class ViewPropertyDetailedDashboard extends StatefulWidget {
  ViewPropertyDetailedDashboard({required this.propsId});

  final String propsId;

  @override
  State<ViewPropertyDetailedDashboard> createState() =>
      _ViewPropertyDetailedDashboardState();
}

class _ViewPropertyDetailedDashboardState
    extends State<ViewPropertyDetailedDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Detail'),
      ),
      body: Container(),
    );
  }
}
