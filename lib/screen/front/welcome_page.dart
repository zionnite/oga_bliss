import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/home_page.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'decide_page.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage();

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // splashController.startAnimation();

    return Scaffold(
      backgroundColor: backgroundColorPrimary,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: height * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.blue.withOpacity(0.9), BlendMode.color),
                    fit: BoxFit.fitWidth,
                    image: const AssetImage('assets/images/connect_home.png'),
                  ),
                ),
              ),
              Column(
                children: const [
                  Text(
                    'Find Your Dream Home',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Passion One',
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'OgaBliss, has the best and finest agents that will connect you with your dream home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue.shade900,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(),
                            side: const BorderSide(color: Colors.blue),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed: () {
                            Get.offAll(() => const LoginPage());
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(),
                            side: const BorderSide(color: Colors.white),
                            backgroundColor: Colors.blue.shade900,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed: () {
                            Get.offAll(() => const DecidePage());
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool('isGuestLogin', true);
                      Get.offAll(() => const HomePage());
                    },
                    child: const Text(
                      'Login As a Guest & Decide later',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
