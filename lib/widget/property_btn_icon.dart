import 'package:flutter/material.dart';

class PropertyBtnIcon extends StatefulWidget {
  PropertyBtnIcon({
    required this.onTap,
    required this.title,
    required this.bgColor,
    required this.icon,
    required this.icon_color,
    required this.icon_size,
  });

  final VoidCallback onTap;
  final String title;
  final Color bgColor;
  final IconData icon;
  final Color icon_color;
  final double icon_size;

  @override
  State<PropertyBtnIcon> createState() => _PropertyBtnIconState();
}

class _PropertyBtnIconState extends State<PropertyBtnIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 10,
          top: 10,
        ),
        elevation: 10,
        child: Ink(
          color: widget.bgColor,
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
              top: 10,
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: widget.icon_color,
                    size: widget.icon_size,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Passion One',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
