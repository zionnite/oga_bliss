import 'package:flutter/material.dart';

class messageWidget extends StatelessWidget {
  const messageWidget({
    required this.image_name,
    required this.name,
    required this.status,
    required this.onTap,
    required this.time,
    required this.last_msg,
    required this.counter,
  });
  final String image_name;
  final String name;
  final String status;
  final VoidCallback onTap;
  final String time;
  final String last_msg;
  final String counter;

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
              Stack(
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
                  (int.parse(counter) > 0)
                      ? Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 8,
                            ),
                            child: Text(
                              counter,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : Container(),
                ],
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
                      Text(
                        last_msg,
                        style: const TextStyle(
                          fontFamily: 'Lobster',
                          color: Colors.grey,
                        ),
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
