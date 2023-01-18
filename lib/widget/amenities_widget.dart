import 'package:flutter/material.dart';
import 'package:oga_bliss/widget/property_key.dart';

class AmenitiesWidget extends StatelessWidget {
  AmenitiesWidget({required this.isYes, required this.name});
  final String isYes;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            (isYes == 'yes')
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            const SizedBox(
              width: 1,
            ),
            Expanded(
              child: PropertyKey(
                propsKey: name,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
