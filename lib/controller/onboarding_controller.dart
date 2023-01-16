import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../model/onboarding_model.dart';
import '../widget/onboarding_widget.dart';

class OnboardingCongroller extends GetxController {
  OnboardingCongroller get getXID => Get.find<OnboardingCongroller>();

  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/agent_and_ten.png',
        title: 'OgaBliss',
        sub_title:
            'In here we connect you with the right Agents / Landlords  and Tenant ',
        counter: '1/4',
        bgColor: Colors.blue,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/rent.png',
        title: 'Rent Property',
        sub_title:
            'Getting the right apartment or comfort has never be easier, OgaBliss bring the right Agent to you',
        counter: '2/4',
        bgColor: Colors.blue,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/build_connection.png',
        title: 'Purchase Property',
        sub_title:
            'With OgaBliss, you don\'t have to worry about the hustle of settling community or paying double fees for property',
        counter: '3/4',
        bgColor: Colors.blue,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/connected.png',
        title: 'OgaBliss',
        sub_title:
            'Click the Continue button below to a new door of celebration',
        counter: '4/4',
        bgColor: Colors.blue,
      ),
    ),
  ];

  onPageChanged(int activePageIndex) => currentPage.value = activePageIndex;
  skip() => controller.jumpToPage(page: 3);

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
