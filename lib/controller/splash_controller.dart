import 'dart:async';

import 'package:get/get.dart';
import 'package:oga_bliss/screen/front/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';
import '../screen/front/onboarding_screen.dart';

class SplashController extends GetxController {
  SplashController get getXID => Get.find<SplashController>();

  RxBool animate = false.obs;
  late Timer timer1, timer2;

  Future startAnimation() async {
    if (!animate.value) {
      await Future.delayed(const Duration(milliseconds: 500));
      animate.value = true;
      await Future.delayed(const Duration(milliseconds: 7000));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var isUserLogin = prefs.getBool('isUserLogin');
      var isGuestLogin = prefs.getBool('isGuestLogin');
      var isFirstTime = prefs.getBool('isFirstTime');
      var userId1 = prefs.getString('user_id');
      var demoStatus = prefs.getBool("displayShowCase");

      if (isFirstTime == null) {
        Get.offAll(() => OnboardingPage());
      }

      if (isUserLogin != null) {
        Get.offAll(() => const HomePage());
      } else {
        if (isGuestLogin != null) {
          Get.offAll(() => const HomePage());
        } else {
          Get.to(() => const WelcomePage());
        }
      }
    }
  }
}
