import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oga_bliss/screen/front/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/alert_controller.dart';
import 'controller/chat_head_controller.dart';
import 'controller/connection_controller.dart';
import 'controller/favourite_controller.dart';
import 'controller/onboarding_controller.dart';
import 'controller/property_controller.dart';
import 'controller/request_controller.dart';
import 'controller/splash_controller.dart';
import 'controller/transaction_controller.dart';
import 'controller/users_controller.dart';
import 'controller/wallet_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SplashController());
  Get.put(OnboardingCongroller());
  Get.put(PropertyController());
  Get.put(FavouriteController());
  Get.put(RequestController());
  Get.put(ConnectionController());
  Get.put(TransactionController());
  Get.put(AlertController());
  Get.put(ChatHeadController());
  Get.put(WalletController());
  Get.put(UsersController());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isUserLogin = prefs.getBool('isUserLogin');
  var isFirstTime = prefs.getBool('isFirstTime');
  var userId1 = prefs.getString('user_id');
  var demoStatus = prefs.getBool("displayShowCase");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(
        isUserLogin: isUserLogin,
        isFirstTIme: isFirstTime,
        userId: userId1,
        demoStatus: demoStatus,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({
    required this.isUserLogin,
    required this.isFirstTIme,
    required this.userId,
    required this.demoStatus,
  });

  late var isUserLogin;
  late var isFirstTIme;
  late var userId;
  late var demoStatus;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('status', true);
    // prefs.setBool('validation', true);
    // prefs.setString('user_status', "user");
    // prefs.setString('online_status', "online");
  }

  @override
  Widget build(BuildContext context) {
    addStringToSF();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
