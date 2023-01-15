import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: [
              Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    Image(
                      image: const AssetImage(
                        'assets/images/home_love.png',
                      ),
                      height: height * 0.6,
                      color: Colors.blue.withOpacity(1),
                      colorBlendMode: BlendMode.color,
                    ),
                    const Text(
                      'Welcome to OgaBliss',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                        'Get Connected to Reputable landlord and Agent in Your city')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
