import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PropertyBtnIcon extends StatefulWidget {
  PropertyBtnIcon({
    required this.onTap,
    required this.title,
    required this.bgColor,
    required this.icon,
    required this.icon_color,
    required this.icon_size,
    this.isSuffix = false,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final String title;
  final Color bgColor;
  final IconData icon;
  final Color icon_color;
  final double icon_size;
  final bool isSuffix;
  final bool isLoading;

  @override
  State<PropertyBtnIcon> createState() => _PropertyBtnIconState();
}

class _PropertyBtnIconState extends State<PropertyBtnIcon> {
  @override
  Widget build(BuildContext context) {
    print('sdfd ${widget.isLoading}');
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
              child: (widget.isLoading)
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (!widget.isSuffix)
                            ? Icon(
                                widget.icon,
                                color: widget.icon_color,
                                size: widget.icon_size,
                              )
                            : Container(),
                        Text(
                          widget.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Passion One',
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        (widget.isSuffix)
                            ? Icon(
                                widget.icon,
                                color: widget.icon_color,
                                size: widget.icon_size,
                              )
                            : Container(),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
