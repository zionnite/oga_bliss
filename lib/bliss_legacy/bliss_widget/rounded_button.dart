import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RoundedButton extends StatefulWidget {
  RoundedButton({
    required this.bgColor,
    required this.txtColor,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  final Color bgColor;
  final Color txtColor;
  final String title;
  final VoidCallback onTap;
  final isLoading;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
          ),
          elevation: 2,
          color: widget.bgColor,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white30,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
                right: 5,
                left: 5,
              ),
              child: (widget.isLoading)
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                  : Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.txtColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
