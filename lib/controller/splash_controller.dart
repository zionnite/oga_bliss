import 'package:get/get.dart';
import 'package:oga_bliss/screen/front/onboarding_screen.dart';

class SplashController extends GetxController {
  static SplashController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 7000));
    Get.to(() => const OnboardingPage());
  }
}
