import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/widget/header_title.dart';

import '../widget/property_btn.dart';
import '../widget/property_key.dart';
import 'favourite.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String width = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   automaticallyImplyLeading: false,
      // ),
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 190.0),
          child: Column(
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
                  Positioned(
                    top: 40,
                    left: 5,
                    child: Row(
                      children: const [
                        Text(''),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 5,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,

                                //size: 30,
                              ),
                              onPressed: () => Get.to(
                                () => const FavouritePage(),
                                transition: Transition.zoom,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => const FavouritePage(),
                                  transition: Transition.zoom,
                                );
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
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

              // const SizedBox(
              //   height: 15,
              // ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Card(
              //     color: Colors.blue,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(45.0),
              //     ),
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 30.0, vertical: 15),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: const [
              //           Text(
              //             'Edit Profile',
              //             style: TextStyle(
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
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
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const HeaderTitle(
                  title: 'Email',
                  icon: Icon(Icons.email),
                ),
              ),
              const PropertyKey(
                propsKey: 'email@email.com',
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const HeaderTitle(
                  title: 'Phone',
                  icon: Icon(Icons.phone_android_sharp),
                ),
              ),
              const PropertyKey(
                propsKey: '09093537343',
              ),
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
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const HeaderTitle(
                  title: 'Address',
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 0,
                ),
                child: const Text(
                  '10, Osemwengie street off akugbe road, off upper sakponba road benin city, edo state, Nigeria',
                  style: TextStyle(fontSize: 20),
                ),
              ),

              // const PropertyKey(
              //   propsKey:
              //       '10, Osemwengie street off akugbe road, off upper sakponba road benin city, edo state, Nigeria',
              // ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const HeaderTitle(
                  title: 'Bank Name',
                ),
              ),
              const PropertyKey(
                propsKey: 'Uba',
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const HeaderTitle(
                  title: 'Account Number',
                ),
              ),
              const PropertyKey(
                propsKey: '09143768',
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const HeaderTitle(
                  title: 'Account Name',
                ),
              ),
              const PropertyKey(
                propsKey: 'James Osadolor Cresent',
              ),
              propertyBtn(
                onTap: () {
                  print('hello printed');
                },
                title: 'Verify Bank Account',
                bgColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
