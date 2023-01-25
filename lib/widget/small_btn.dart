import 'package:flutter/material.dart';

class smallBtn extends StatefulWidget {
  smallBtn({
    required this.btnName,
    required this.btnColor,
    required this.onTap,
    this.font_size,
    this.isLoading = false,
    this.loadingColor,
  });
  final String btnName;
  final Color btnColor;
  final VoidCallback onTap;
  final double? font_size;
  final bool isLoading;
  final Color? loadingColor;

  @override
  State<smallBtn> createState() => _smallBtnState();
}

class _smallBtnState extends State<smallBtn> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.btnColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (widget.isLoading)
                ? Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: (widget.isLoading)
                            ? widget.loadingColor
                            : Colors.blue,
                      ),
                    ),
                  )
                : Text(
                    widget.btnName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          (widget.font_size != "null" && widget.font_size != "")
                              ? widget.font_size
                              : 15,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
