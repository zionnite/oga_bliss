import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:oga_bliss/util/currency_formatter.dart';

import '../model/onboarding_model.dart';
import '../widget/onboarding_widget.dart';

class OnboardingCongroller extends GetxController {
  OnboardingCongroller get getXID => Get.find<OnboardingCongroller>();

  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/coin_2.png',
        title: 'OgaBliss',
        sub_title:
            'We provide you simple and easy way to make you become a property owner',
        counter: '1/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/subscription.png',
        title: 'Subscription',
        sub_title:
            'Start your journey of becoming a property owner with ${CurrencyFormatter.getCurrencyFormatter(amount: '1000')} daily',
        counter: '2/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/earning.png',
        title: 'Earning',
        sub_title: 'OgaBliss provide you simple way to earn on it\'s Platform',
        counter: '3/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/agent_and_ten.png',
        title: 'OgaBliss',
        sub_title:
            'In here we connect you with the right Agents / Landlords  and Tenant ',
        counter: '4/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/build_connection.png',
        title: 'Purchase Property',
        sub_title:
            'With OgaBliss, you don\'t have to worry about the hustle of settling community or paying double fees for property',
        counter: '5/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/rent.png',
        title: 'Rent Property',
        sub_title:
            'Getting the right apartment or comfort has never be easier, OgaBliss bring the right Agent to you',
        counter: '6/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
    onboardingWidget(
      model: OnboardingModel(
        image_name: 'assets/images/connected.png',
        title: 'OgaBliss',
        sub_title:
            'Click the Continue button below to a new door of celebration',
        counter: '7/7',
        bgColor: Colors.blue.shade900,
      ),
    ),
  ];

  onPageChanged(int activePageIndex) => currentPage.value = activePageIndex;
  skip() => controller.jumpToPage(page: 6);

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
