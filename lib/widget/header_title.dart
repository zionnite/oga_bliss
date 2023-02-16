import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  const HeaderTitle({
    required this.title,
    this.icon,
  });
  final String title;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return (icon == null)
        ? Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: Text(
              '-$title-',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Passion One',
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 20,
            ),
            child: Row(
              children: [
                icon!,
                const SizedBox(width: 5),
                Text(
                  '$title',
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Passion One',
                  ),
                ),
              ],
            ),
          );
  }
}
