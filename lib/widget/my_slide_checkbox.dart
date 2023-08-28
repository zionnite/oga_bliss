import 'package:flutter/material.dart';

class MySlideCheckBox extends StatefulWidget {
  MySlideCheckBox({
    required this.isSwitched,
    required this.onChanged,
  });

  final bool isSwitched;
  final ValueChanged onChanged;

  @override
  State<MySlideCheckBox> createState() => _MySlideCheckBoxState();
}

class _MySlideCheckBoxState extends State<MySlideCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isSwitched,
      onChanged: widget.onChanged,
      activeTrackColor: Colors.blue,
      activeColor: Colors.white,
    );
  }
}
