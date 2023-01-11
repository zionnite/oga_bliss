import 'package:flutter/material.dart';

enum propertyModeEnum { New, Furnished, Serviced }

class MyRadioBtnField extends StatelessWidget {
  MyRadioBtnField({
    required this.title,
    required this.value,
    this.selectedProperty,
    this.onChanged,
  });

  final String title;
  final propertyModeEnum value;
  final propertyModeEnum? selectedProperty;
  final Function(propertyModeEnum?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<propertyModeEnum>(
      title: Text(title),
      value: value,
      groupValue: selectedProperty,
      onChanged: onChanged,
    );
  }
}
