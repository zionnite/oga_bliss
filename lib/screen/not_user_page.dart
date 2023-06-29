import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/screen/front/welcome_page.dart';
import 'package:oga_bliss/widget/property_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotUserPage extends StatefulWidget {
  const NotUserPage({Key? key}) : super(key: key);

  @override
  State<NotUserPage> createState() => _NotUserPageState();
}

class _NotUserPageState extends State<NotUserPage> {
  String? user_id;
  String? user_status;
  bool? admin_status;
  bool? guestStatus;
  bool? loginStatus;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isGuestLogin = prefs.getBool('isGuestLogin');
    var isUserLogin = prefs.getBool('isUserLogin');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
        guestStatus = isGuestLogin;
        loginStatus = isUserLogin;
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
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Card(
                margin: const EdgeInsets.only(
                    top: 5, left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/data_not_found.png',
                      height: 290,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Only Login Members with Status (User) can view this page',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Passion One',
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            (loginStatus == null)
                ? propertyBtn(
                    onTap: () {
                      Get.to(() => const WelcomePage());
                    },
                    title: 'Login Now',
                    bgColor: Colors.blue.shade700,
                    card_margin: const EdgeInsets.only(
                      top: 8,
                      bottom: 1,
                      right: 8,
                      left: 8,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
