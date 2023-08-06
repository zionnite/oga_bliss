import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color backgroundColorPrimary = Colors.blue.shade900;
Color backgroundColorLight = const Color(0xff7c43bd);
Color backgroundColorDark = const Color(0xff512DA8);
Color backgroundColorAccent = Colors.purple;
Color textColorWhite = const Color(0xffffffff);

Color blackColor = const Color(0xff19191b);
Color greyColor = const Color(0xff8f8f8f);
Color blueColor = const Color(0xff2b9ed4);
Color userCircleBackground = const Color(0xff2b2b33);
Color onlineDotColor = const Color(0xff46dc64);
Color lightBlueColor = const Color(0xff0077d7);
Color separatorColor = const Color(0xff272c35);

Color gradientColorStart = const Color(0xff00b6f3);
Color gradientColorEnd = const Color(0xff0184dc);

Color senderColor = const Color(0xff2b343b);
Color receiverColor = const Color(0xff1e2225);

Gradient fabGradient = LinearGradient(
  colors: [backgroundColorPrimary, backgroundColorAccent],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

Gradient bgColorGradient = const LinearGradient(
  colors: [Colors.purpleAccent, Colors.purple],
);

showSnackBar({
  required String title,
  required String msg,
  required Color backgroundColor,
  Duration duration = const Duration(seconds: 3),
}) {
  Get.snackbar(
    title,
    msg,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: duration,
    // duration:
  );
}

const int CURRENT_APP_VERSION = 2;
const String baseDomain = 'https://ogabliss.com/';
const String baseUrl = '${baseDomain}Api/';
const String baseUrlSec = '${baseDomain}ApiMlm/';

// const String baseUrl  = 'https://ogabliss.com/Api/';
// const String baseUrlSec  = 'https://ogabliss.com/ApiMlm/';
