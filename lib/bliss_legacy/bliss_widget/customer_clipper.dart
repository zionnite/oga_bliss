import 'package:flutter/material.dart';

class BlissCustomClipper extends StatefulWidget {
  const BlissCustomClipper({required this.name, required this.isSelected});
  final String name;
  final bool isSelected;

  @override
  State<BlissCustomClipper> createState() => _BlissCustomClipperState();
}

class _BlissCustomClipperState extends State<BlissCustomClipper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 100,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: (widget.isSelected) ? Colors.white : Colors.blue.shade900,
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.name,
          style: TextStyle(
            color: (widget.isSelected) ? Colors.blue : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
