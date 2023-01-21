import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oga_bliss/screen/front/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/favourite_controller.dart';
import 'controller/onboarding_controller.dart';
import 'controller/property_controller.dart';
import 'controller/splash_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SplashController());
  Get.put(OnboardingCongroller());
  Get.put(PropertyController());
  Get.put(FavouriteController());
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
