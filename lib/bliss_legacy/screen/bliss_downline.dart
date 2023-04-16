import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_dashboard.dart';
import 'package:oga_bliss/widget/message_widget.dart';

class BlissDownline extends StatefulWidget {
  const BlissDownline({Key? key}) : super(key: key);

  @override
  State<BlissDownline> createState() => _BlissDownlineState();
}

class _BlissDownlineState extends State<BlissDownline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 160.0, top: 20.0),
                  child: Text(
                    'Your Downline & Generation',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            padding:
                const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 80),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
              messageWidget(
                image_name:
                    'https://images.unsplash.com/photo-1597223557154-721c1cecc4b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW4lMjBmYWNlfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                name: 'Nosakhare Atekha',
                status: 'Male',
                onTap: () {
                  Get.to(
                    () => BlissDashboard(),
                  );
                },
                time: '3hrs ago',
                last_msg: '1 Subscription Plan',
                counter: '0',
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          )
        ],
      )),
    );
  }
}
