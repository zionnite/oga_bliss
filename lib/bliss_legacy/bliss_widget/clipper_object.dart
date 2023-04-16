import 'package:flutter/material.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/customer_clipper.dart';

class BlissClipperObject extends StatefulWidget {
  BlissClipperObject({this.marginVal = 188.0});
  final double marginVal;

  @override
  State<BlissClipperObject> createState() => _BlissClipperObjectState();
}

class _BlissClipperObjectState extends State<BlissClipperObject> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.marginVal),
      child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.transparent,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              BlissCustomClipper(name: 'Building Plan'),
              BlissCustomClipper(name: 'Lands Plan'),
              BlissCustomClipper(name: 'Daily Plan'),
              BlissCustomClipper(name: 'Weekly Plan'),
            ],
          ),
        ),
      ),
    );
  }
}
