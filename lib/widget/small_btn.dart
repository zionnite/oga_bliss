import 'package:flutter/material.dart';

class smallBtn extends StatelessWidget {
  smallBtn({
    required this.btnName,
    required this.btnColor,
    required this.onTap,
    this.font_size,
  });
  final String btnName;
  final Color btnColor;
  final VoidCallback onTap;
  final double? font_size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              btnName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize:
                    (font_size != "null" && font_size != "") ? font_size : 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
