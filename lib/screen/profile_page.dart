import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/widget/profile_item.dart';
import 'package:oga_bliss/widget/property_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile.dart';
import 'verify_bank.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usersController = UsersController().getXID;
  String? user_id;
  String? user_status;
  bool? admin_status;

  String? full_name;
  String? phone;
  String? email;
  String? age;
  String? sex;

  String? accountName;
  String? accountNum;
  String? bankName;
  String? bankCode;

  String? image_name;
  String? isbank_verify;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    var phone1 = prefs.getString('phone');
    var email1 = prefs.getString('email');
    var age1 = prefs.getString('age');
    var sex1 = prefs.getString('sex');
    var account_name1 = prefs.getString('account_name');
    var account_number1 = prefs.getString('account_number');
    var bank_name1 = prefs.getString('bank_name');
    var image_name1 = prefs.getString('image_name');
    var isbank_verify1 = prefs.getString('isbank_verify');
    var fullName1 = prefs.getString('full_name');
    var bankCode1 = prefs.getString('bank_code');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
        phone = phone1;
        email = email1;
        age = age1;
        sex = sex1;
        accountName = account_name1;
        accountNum = account_number1;
        bankName = bank_name1;
        image_name = image_name1;
        isbank_verify = isbank_verify1;
        full_name = fullName1!;
        bankCode = bankCode1;
      });
    }
  }

  bool isLoading = false;
  final String width = '';
  File? _image;
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);

      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {}
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

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
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 68,
                        backgroundImage: NetworkImage(
                          '$image_name',
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 55,
                        child: (isLoading)
                            ? Center(
                                child: LoadingAnimationWidget.inkDrop(
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : Container(),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 4,
                        child: InkWell(
                          onTap: () async {
                            await _pickImage(
                              ImageSource.gallery,
                            );

                            setState(() {
                              isLoading = true;
                            });

                            var status = await usersController.uploadImage(
                              user_id,
                              _image!,
                            );

                            if (status == false) {
                              setState(() {
                                isLoading = false;
                              });
                            }

                            if (status != false) {
                              setState(() {
                                isLoading = false;
                              });
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('image_name', status);
                            }
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 29,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Text(
                  '$full_name',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Text(
                  '$user_status'.toUpperCase(),
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
                padding: const EdgeInsets.only(left: 28.0),
                child: SizedBox(
                  height: 20.0,
                  width: 150,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
              ),

              ProfileItem(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                name: '$phone',
              ),
              ProfileItem(
                icon: const Icon(
                  Icons.email,
                  color: Colors.blue,
                ),
                name: '$email',
              ),
              ProfileItem(
                icon: const Icon(
                  Icons.star_sharp,
                  color: Colors.blue,
                ),
                name: '$age',
              ),
              ProfileItem(
                icon: const Icon(
                  Icons.accessibility_new,
                  color: Colors.blue,
                ),
                name: '$sex',
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

              ProfileItem(
                icon: const Icon(
                  Icons.food_bank,
                  color: Colors.blue,
                ),
                name: '$accountName',
              ),

              ProfileItem(
                icon: const Icon(
                  Icons.food_bank,
                  color: Colors.blue,
                ),
                name: '$bankName - $accountNum',
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
                      title: 'Edit Bank Detail',
                      bgColor: Colors.blue.shade700,
                      card_margin: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 0,
                        top: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: propertyBtn(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        bool status = await usersController.verifyBank(
                          accountNum: accountNum!,
                          bankCode: bankCode!,
                          my_id: user_id!,
                        );

                        if (status || !status) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      title: 'Verify Bank',
                      bgColor: Colors.blue.shade700,
                      isLoading: isLoading,
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
