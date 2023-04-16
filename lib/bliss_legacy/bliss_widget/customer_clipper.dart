import 'package:flutter/material.dart';

class BlissCustomClipper extends StatefulWidget {
  const BlissCustomClipper({required this.name});
  final String name;

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
        color: Colors.blue.shade900,
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
