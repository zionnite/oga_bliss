import 'package:flutter/material.dart';

class MyNumField extends StatefulWidget {
  MyNumField({
    required this.myTextFormController,
    required this.fieldName,
    this.onChange,
    this.prefix,
    this.suffix,
    this.hintText,
  });

  final TextEditingController myTextFormController;
  final String fieldName;
  final ValueChanged<String>? onChange;
  final IconData? prefix;
  final IconData? suffix;
  final String? hintText;

  @override
  State<MyNumField> createState() => _MyNumFieldState();
}

class _MyNumFieldState extends State<MyNumField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: widget.onChange,
        controller: widget.myTextFormController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          labelText: widget.fieldName,
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
