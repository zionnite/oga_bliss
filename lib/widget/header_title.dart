import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 20,
      ),
      child: Text(
        '-$title-',
        style: const TextStyle(
          fontSize: 25,
          fontFamily: 'Passion One',
        ),
      ),
    );
  }
}
