import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/screen/alert_page.dart';
import 'package:oga_bliss/screen/message_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyAppBar extends StatefulWidget {
  const PropertyAppBar({
    required this.title,
  });
  final String title;

  @override
  State<PropertyAppBar> createState() => _PropertyAppBarState();
}

class _PropertyAppBarState extends State<PropertyAppBar> {
  String? user_id;
  String? user_status;
  bool? admin_status;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

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
                  Get.to(() => const AlertPage());
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
              (user_status == 'admin' || user_status == 'super_admin')
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Get.to(() => const MessagePage());
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
              widget.title,
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
