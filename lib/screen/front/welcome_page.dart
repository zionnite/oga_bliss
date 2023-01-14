import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/home_page.dart';

import '../../controller/splash_controller.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // splashController.startAnimation();

    return Scaffold(
      backgroundColor: Colors.blue,
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
                            foregroundColor: Colors.blue.shade700,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(),
                            side: const BorderSide(color: Colors.blue),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed: () {
                            print('hey');
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
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          onPressed: () {
                            print('hey');
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
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const HomePage());
                      },
                      child: const Text(
                        'Login As a Guest & Decide later',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
