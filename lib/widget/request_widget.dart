import 'package:flutter/material.dart';
import 'package:oga_bliss/widget/small_btn.dart';

class requestWidget extends StatelessWidget {
  requestWidget({
    required this.name,
    required this.time,
    required this.status,
    required this.image_name,
    required this.btnName,
    required this.btnColor,
    required this.btnTap,
    required this.onTap,
  });

  final String image_name;
  final String name;
  final String time;
  final String status;
  final String btnName;
  final Color btnColor;
  final VoidCallback btnTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      image_name,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Time: ${time}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Status: ${status}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                smallBtn(
                  btnName: btnName,
                  btnColor: btnColor,
                  onTap: btnTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
