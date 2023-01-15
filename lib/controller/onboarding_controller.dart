import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../model/onboarding_model.dart';
import '../widget/onboarding_widget.dart';

class OnboardingCongroller extends GetxController {
  static OnboardingCongroller get find => Get.find();

  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/a.jpeg',
        title: 'OgaBliss',
        sub_title: 'Connect Users',
        counter: '1/3',
        bgColor: Colors.blue,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/a.jpeg',
        title: 'OgaBliss',
        sub_title: 'Connect Users',
        counter: '2/3',
        bgColor: Colors.green,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/a.jpeg',
        title: 'OgaBliss',
        sub_title: 'Connect Users',
        counter: '3/3',
        bgColor: Colors.red,
      ),
    ),
  ];

  onPageChanged(int activePageIndex) => currentPage.value = activePageIndex;
  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
