import 'dart:async';

import 'package:get/get.dart';

import '../screen/front/onboarding_screen.dart';

class SplashController extends GetxController {
  static SplashController get find => Get.find();

  RxBool animate = false.obs;
  late Timer timer1, timer2;

  Future startAnimation() async {
    timer1 = Timer(Duration(milliseconds: 500), () {
      animate.value = true;
    });

    timer2 = Timer(Duration(milliseconds: 7000), () {
      timer1.cancel();
      timer2.cancel();
      Get.to(() => OnboardingPage(
            timer1: timer1,
            timer2: timer2,
          ));
    });
    //t.cancel();

    // await Future.delayed(const Duration(milliseconds: 500));
    // animate.value = true;
    // await Future.delayed(const Duration(milliseconds: 7000));
    // Get.to(() => const OnboardingPage());
  }
}
