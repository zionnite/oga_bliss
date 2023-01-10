import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    required this.myTextFormController,
    required this.fieldName,
    this.onChange,
  });

  final TextEditingController myTextFormController;
  final String fieldName;
  final ValueChanged<String>? onChange;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextField(
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
        ),
      ),
    );
  }
}
