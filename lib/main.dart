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
import 'controller/wallet_controller.dart';

void main() {
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
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', "1");
    prefs.setString('phone_no', "090");
    prefs.setString('user_name', "doe");
    prefs.setString('user_img', "https://");
    prefs.setString('email', "email@email.com");
    prefs.setString('full_name', "Jone");
    prefs.setBool('status', true);
    prefs.setBool('validation', true);
    prefs.setString('user_status', "user");
    prefs.setString('online_status', "online");
    prefs.setBool('admin_status', false);
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
