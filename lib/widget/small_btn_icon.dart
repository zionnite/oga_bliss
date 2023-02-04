import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class smallBtnIcon extends StatelessWidget {
  smallBtnIcon({
    required this.btnName,
    required this.btnColor,
    required this.onTap,
    required this.icon,
    required this.icon_color,
    this.icon_size,
    this.font_size,
    this.isLoading = false,
  });
  final String btnName;
  final Color btnColor;
  final VoidCallback onTap;
  final IconData icon;
  final Color icon_color;
  final double? icon_size;
  final double? font_size;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: btnColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (isLoading)
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
                      Icon(
                        icon,
                        size: icon_size,
                        color: icon_color,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        btnName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: (font_size != "null" && font_size != "")
                              ? font_size
                              : 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
