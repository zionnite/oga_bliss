import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/screen/front/login_page.dart';
import 'package:oga_bliss/screen/verify_bank.dart';
import 'package:oga_bliss/widget/property_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen/edit_profile.dart';
import '../../widget/property_key.dart';

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
  String? m_ref_code;
  String? m_ref_link;

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

    var m_ref_code1 = prefs.getString('m_ref_code');
    var m_ref_link1 = prefs.getString('m_ref_link');

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

        m_ref_code = m_ref_code1;
        m_ref_link = m_ref_link1;
      });
    }
  }

  bool isLoading = false;
  bool isEditing = false;
  bool isVerify = false;
  final String width = '';
  File? _image;
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      File? img = File(image.path);

      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isUserLogin");
    prefs.remove("user_id");
    prefs.remove("user_name");
    prefs.remove("full_name");
    prefs.remove("email");
    prefs.remove("image_name");
    prefs.remove("user_status");
    prefs.remove("phone");
    prefs.remove("age");
    prefs.remove("sex");
    prefs.remove("address");
    prefs.remove("date_created");
    prefs.remove("account_name");
    prefs.remove("account_number");
    prefs.remove("bank_name");
    prefs.remove("bank_code");
    prefs.remove("current_balance");
    prefs.remove("prop_counter");
    prefs.remove("admin_status");
    prefs.remove("isbank_verify");
    prefs.remove("login_status");
    prefs.remove("isGuestLogin");

    Get.offAll(
      () => const LoginPage(),
      transition: Transition.rightToLeftWithFade,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile'),
      //   automaticallyImplyLeading: false,
      // ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
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
                Stack(children: [
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.only(
                      top: 310,
                      left: 10,
                      right: 10,
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40, left: 15),
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
                              propsKey: '$full_name',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Divider(height: 1, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 15),
                              child: const Text(
                                'Email',
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
                              propsKey: '$email',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Divider(height: 1, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 15),
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
                              propsKey: '$age',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Divider(height: 1, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 15),
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
                              propsKey: '$sex',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.only(
                        top: 670, left: 10, right: 10, bottom: 0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: const Text(
                              'Bank Name',
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
                            propsKey: '$bankName',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(height: 1, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: const Text(
                              'Account Number',
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
                            propsKey: '$accountNum',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(height: 1, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: const Text(
                              'Account Name',
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
                            propsKey: '$accountName',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.only(
                        top: 915, left: 10, right: 10, bottom: 0),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: const Text(
                              'Referral Code',
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
                            propsKey: '$m_ref_code',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(height: 1, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, left: 15),
                            child: const Text(
                              'Referral Link',
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
                            propsKey: '$m_ref_link',
                          ),
                          const SizedBox(
                            height: 10,
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
                            top: 5,
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

                                  setState(() {
                                    image_name = status;
                                  });
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
                ]),
                Positioned(
                  top: 60,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      logoutUser();
                    },
                    icon: const Icon(
                      Icons.logout_sharp,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            propertyBtn(
              onTap: () {
                Get.to(() => const EditProfile());
              },
              title: 'Edit Profile',
              bgColor: Colors.blue.shade700,
              card_margin: const EdgeInsets.only(
                top: 8,
                bottom: 1,
                right: 8,
                left: 8,
              ),
            ),
            propertyBtn(
              onTap: () {
                Get.to(() => const VerifyBank());
              },
              title: 'Edit Bank Detail',
              bgColor: Colors.blue.shade700,
              card_margin: const EdgeInsets.only(
                top: 8,
                bottom: 1,
                right: 8,
                left: 8,
              ),
            ),
            (isbank_verify == 'yes')
                ? const SizedBox(
                    height: 150,
                  )
                : Container(),
            (isbank_verify == 'yes')
                ? Container()
                : propertyBtn(
                    onTap: () async {
                      setState(() {
                        isVerify = true;
                      });

                      bool status = await usersController.verifyBank(
                        accountNum: accountNum!,
                        bankCode: bankCode!,
                        my_id: user_id!,
                      );

                      if (status || !status) {
                        setState(() {
                          isVerify = false;
                        });
                      }

                      if (status) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('isbank_verify', 'yes');

                        setState(() {
                          isbank_verify = 'yes';
                        });
                      }
                    },
                    title: 'Verify Bank',
                    bgColor: Colors.blue.shade700,
                    isLoading: isVerify,
                    card_margin: const EdgeInsets.only(
                      top: 8,
                      bottom: 10,
                      right: 8,
                      left: 8,
                    ),
                  ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
