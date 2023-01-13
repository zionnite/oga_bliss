import 'package:flutter/material.dart';

class messageWidget extends StatelessWidget {
  const messageWidget({
    required this.image_name,
    required this.name,
    required this.status,
    required this.onTap,
    required this.time,
  });
  final String image_name;
  final String name;
  final String status;
  final VoidCallback onTap;
  final String time;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: NetworkImage(
                    image_name,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Passion One',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(status),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
