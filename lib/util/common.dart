import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(
    {required String title,
    required String msg,
    required Color backgroundColor}) {
  Get.snackbar(
    title,
    msg,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}
