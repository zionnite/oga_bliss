import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/controller/alert_controller.dart';
import 'package:oga_bliss/controller/chat_head_controller.dart';
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
  final alertController = AlertController().getXID;
  final chController = ChatHeadController().getXID;
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

  Timer? timer;

  @override
  void initState() {
    initUserDetail();
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkForUpdate());
  }

  checkForUpdate() async {
    await alertController.checkForUpdate(user_id);
    await chController.checkForUpdate(user_id);
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
                child: Stack(children: [
                  Container(
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
                  Obx(
                    () => (alertController.alertCounter > 0)
                        ? Positioned(
                            top: 3,
                            right: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 1,
                              ),
                              child: Text(
                                '${alertController.alertCounter}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ]),
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
                      child: Stack(children: [
                        Container(
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
                        Obx(
                          () => (chController.msgCounter > 0)
                              ? Positioned(
                                  top: 3,
                                  right: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 1,
                                    ),
                                    child: Text(
                                      '${chController.msgCounter}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ]),
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
