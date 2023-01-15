import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final onboardingController = OnboardingCongroller();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            enableSideReveal: true,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            liquidController: onboardingController.controller,
            onPageChangeCallback: onboardingController.onPageChanged,
            pages: onboardingController.pages,
          ),
          Positioned(
            bottom: 40,
            child: OutlinedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.white60),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                foregroundColor: Colors.white,
              ),
              onPressed: () => onboardingController.animateToNextSlide(),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_sharp,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => onboardingController.skip(),
              child: const Text(
                'skip',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 25,
              child: AnimatedSmoothIndicator(
                activeIndex: onboardingController.currentPage.value,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: Colors.white,
                  dotHeight: 5.0,
                  dotColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
