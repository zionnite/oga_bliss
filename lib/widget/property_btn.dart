import 'package:flutter/material.dart';

class propertyBtn extends StatefulWidget {
  propertyBtn(
      {required this.onTap,
      required this.title,
      required this.bgColor,
      this.isLoading});

  final VoidCallback onTap;
  final String title;
  final Color bgColor;
  final bool? isLoading;

  @override
  State<propertyBtn> createState() => _propertyBtnState();
}

class _propertyBtnState extends State<propertyBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 40,
          top: 20,
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
              child: (widget.isLoading == true)
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Passion One',
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
