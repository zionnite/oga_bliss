import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/widget/profile_item.dart';
import 'package:oga_bliss/widget/property_btn.dart';

import 'edit_profile.dart';
import 'verify_bank.dart';

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
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 190.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 210),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 68,
                    backgroundImage: AssetImage(
                      'assets/images/a.jpeg',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: Text(
                  'Crépin Fadjo',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: Text(
                  'Flutter Developer'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'SourceSansPro',
                    color: Colors.teal.shade100,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: SizedBox(
                  height: 20.0,
                  width: 150,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
              ),

              const ProfileItem(
                icon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                name: '+234 90224242424',
              ),
              const ProfileItem(
                icon: Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                name: 'zionnite@zionni.com',
              ),
              const ProfileItem(
                icon: Icon(
                  Icons.star_sharp,
                  color: Colors.blue,
                ),
                name: '25yrs',
              ),
              const ProfileItem(
                icon: Icon(
                  Icons.accessibility_new,
                  color: Colors.blue,
                ),
                name: 'Male',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: propertyBtn(
                  onTap: () {
                    Get.to(() => const EditProfile());
                  },
                  title: 'Edit Profile',
                  bgColor: Colors.blue.shade700,
                ),
              ),
              // const ProfileItem(
              //   icon: Icon(
              //     Icons.location_city,
              //     color: Colors.blue,
              //   ),
              //   name:
              //       '10, Osemwengie street off akugbe road, off upper sakponba road benin city, edo state, Nigeria',
              // ),
              const SizedBox(
                height: 40,
              ),

              const Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: Text(
                  'Bank Details',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.0),
                child: SizedBox(
                  height: 20.0,
                  width: 150,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
              ),

              const ProfileItem(
                icon: Icon(
                  Icons.food_bank,
                  color: Colors.blue,
                ),
                name: 'Nosakhare Atekha Endurance',
              ),

              const ProfileItem(
                icon: Icon(
                  Icons.food_bank,
                  color: Colors.blue,
                ),
                name: 'UBA - 202020323282',
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: propertyBtn(
                      onTap: () {
                        Get.to(() => const VerifyBank());
                      },
                      title: 'Verify Bank',
                      bgColor: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
