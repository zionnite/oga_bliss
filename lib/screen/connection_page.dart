import 'package:flutter/material.dart';

import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/small_btn_icon.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Connection'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NoticeMe(
                    title: 'Oops!',
                    desc: 'Your bank account is not yet verify!',
                    icon: Icons.warning,
                    icon_color: Colors.red,
                    border_color: Colors.red,
                    btnTitle: 'Verify Now',
                    btnColor: Colors.blue,
                    onTap: () {},
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 5,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage(
                                'assets/images/a.jpeg',
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
                                  const Text(
                                    'Nosakhare Atekha Endurance Zionnite',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Passion One',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text('Agent'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      smallBtnIcon(
                                        btnName: 'View User',
                                        btnColor: Colors.blue,
                                        onTap: () {},
                                        icon: Icons.person,
                                        icon_color: Colors.white,
                                        icon_size: 15,
                                        font_size: 13,
                                      ),
                                      smallBtnIcon(
                                        btnName: 'Message',
                                        btnColor: Colors.green,
                                        onTap: () {},
                                        icon: Icons.email,
                                        icon_color: Colors.white,
                                        icon_size: 15,
                                        font_size: 13,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 5,
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: AssetImage(
                                'assets/images/a.jpeg',
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
                                  const Text(
                                    'Nosakhare Atekha Endurance Zionnite',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Passion One',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text('Agent'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      smallBtnIcon(
                                        btnName: 'View User',
                                        btnColor: Colors.blue,
                                        onTap: () {},
                                        icon: Icons.person,
                                        icon_color: Colors.white,
                                        icon_size: 15,
                                        font_size: 13,
                                      ),
                                      smallBtnIcon(
                                        btnName: 'Message',
                                        btnColor: Colors.green,
                                        onTap: () {},
                                        icon: Icons.email,
                                        icon_color: Colors.white,
                                        icon_size: 15,
                                        font_size: 13,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
