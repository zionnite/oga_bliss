import 'dart:async';

import 'package:get/get.dart';

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
      Get.to(() => OnboardingPage());
    }
  }
}
