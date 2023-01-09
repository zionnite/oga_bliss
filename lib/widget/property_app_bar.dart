import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertyAppBar extends StatelessWidget {
  const PropertyAppBar({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(color: Colors.blue.shade600),
          child: SizedBox(),
        ),
        Positioned(
          top: 60,
          left: 15,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          right: 15,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Colors.blue.shade100,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.notifications_sharp,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    border: Border.all(
                      color: Colors.blue.shade100,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 140,
          left: 15,
          child: Container(
            decoration: const BoxDecoration(),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Passion One',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
