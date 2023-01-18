import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oga_bliss/screen/front/splash_page.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
