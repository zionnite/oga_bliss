import 'package:flutter/material.dart';

class NoticeMe extends StatefulWidget {
  NoticeMe({
    required this.title,
    required this.desc,
    required this.icon,
    required this.icon_color,
    required this.border_color,
    required this.btnTitle,
    required this.btnColor,
    required this.onTap,
  });

  final String title;
  final String desc;
  final IconData icon;
  final Color icon_color;
  final Color border_color;
  final String btnTitle;
  final Color btnColor;
  final VoidCallback onTap;
  @override
  State<NoticeMe> createState() => _NoticeMeState();
}

class _NoticeMeState extends State<NoticeMe> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: widget.border_color,
                width: 5,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.red,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                widget.desc,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: widget.onTap,
                child: Text(
                  widget.btnTitle,
                  style: TextStyle(
                    color: widget.btnColor,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
