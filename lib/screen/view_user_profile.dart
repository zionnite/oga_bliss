import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/header_title.dart';
import '../widget/property_key.dart';

class ViewUserProfile extends StatefulWidget {
  ViewUserProfile({required this.id});

  final String id;

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  final usersController = UsersController().getXID;

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

    usersController.getDisUser(user_id!);
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 190.0),
          child: Obx(
            () => ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: usersController.disUsersList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 280,
                          decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            image: DecorationImage(
                              image: AssetImage('assets/images/a.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 210),
                          child: const CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage(
                              'assets/images/a.jpeg',
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const HeaderTitle(
                        title: 'Full Name',
                        icon: Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: PropertyKey(
                        propsKey: 'Nosakhare Atekha Endurance Zionnite',
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 10),
                    //   child: const HeaderTitle(
                    //     title: 'Email',
                    //     icon: Icon(Icons.email),
                    //   ),
                    // ),
                    // const PropertyKey(
                    //   propsKey: 'email@email.com',
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 10),
                    //   child: const HeaderTitle(
                    //     title: 'Phone',
                    //     icon: Icon(Icons.phone_android_sharp),
                    //   ),
                    // ),
                    // const PropertyKey(
                    //   propsKey: '09093537343',
                    // ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const HeaderTitle(
                        title: 'Age',
                      ),
                    ),
                    const PropertyKey(
                      propsKey: '35yrs',
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const HeaderTitle(
                        title: 'Sex',
                        icon: Icon(Icons.support_agent),
                      ),
                    ),
                    const PropertyKey(
                      propsKey: 'Male',
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 10),
                    //   child: const HeaderTitle(
                    //     title: 'Address',
                    //   ),
                    // ),

                    // Container(
                    //   margin: const EdgeInsets.only(
                    //     left: 15,
                    //     right: 15,
                    //     bottom: 0,
                    //   ),
                    //   child: const Text(
                    //     '10, Osemwengie street off akugbe road, off upper sakponba road benin city, edo state, Nigeria',
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    // ),

                    // const PropertyKey(
                    //   propsKey:
                    //       '10, Osemwengie street off akugbe road, off upper sakponba road benin city, edo state, Nigeria',
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
