import 'package:flutter/material.dart';

class PropertyKey extends StatelessWidget {
  const PropertyKey({
    required this.propsKey,
  });

  final String propsKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        bottom: 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SelectableText(
              propsKey,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
