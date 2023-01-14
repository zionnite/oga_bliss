import 'package:get/get.dart';
import 'package:oga_bliss/screen/front/welcome_page.dart';

class SplashController extends GetxController {
  static SplashController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate(true);
    await Future.delayed(const Duration(milliseconds: 5000));
    Get.to(() => const WelcomePage());
  }
}
