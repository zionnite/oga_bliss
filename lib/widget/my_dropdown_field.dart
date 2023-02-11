import 'package:flutter/material.dart';

class MyDropDownField<T> extends StatefulWidget {
  MyDropDownField({
    required this.value,
    required this.dropDownList,
    required this.onChanged,
    required this.labelText,
    this.prefix,
  });

  late final T value;
  final List<DropdownMenuItem<T>> dropDownList;
  final ValueChanged<T> onChanged;
  final String labelText;
  final IconData? prefix;

  @override
  State<MyDropDownField> createState() => _MyDropDownFieldState();
}

class _MyDropDownFieldState extends State<MyDropDownField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white30,
        prefixIcon: (widget.prefix != '' && widget.prefix != null)
            ? Icon(widget.prefix)
            : null,
      ),
      isExpanded: true,
      value: widget.value,
      items: widget.dropDownList,
      onChanged: widget.onChanged,
    );
  }
}
