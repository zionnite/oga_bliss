import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    usersController.getDisUser(widget.id);
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
                var list = usersController.disUsersList[index];
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
                        Stack(children: [
                          Card(
                            elevation: 5,
                            margin: const EdgeInsets.only(
                              top: 310,
                              left: 10,
                              right: 10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 40, left: 15),
                                    child: const Text(
                                      'Full Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Passion One',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  PropertyKey(
                                    propsKey: '${list.agentFullName}',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 28.0),
                                    child:
                                        Divider(height: 1, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: const Text(
                                      'Age',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Passion One',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  PropertyKey(
                                    propsKey: '${list.agentAge}',
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 28.0),
                                    child:
                                        Divider(height: 1, color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, left: 15),
                                    child: const Text(
                                      'Gender',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Passion One',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  PropertyKey(
                                    propsKey: '${list.agentSex}',
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 210),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(
                                '${list.agentImageName}',
                              ),
                            ),
                          ),
                        ]),
                      ],
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
