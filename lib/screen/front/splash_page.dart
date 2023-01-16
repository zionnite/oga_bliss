import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    splashController.startAnimation();
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splashController.animate.value ? 110 : 400,
              right: splashController.animate.value ? 0 : -50,
              left: splashController.animate.value ? 0 : 0,
              child: Column(
                children: [
                  Image(
                    fit: BoxFit.contain,
                    image: const AssetImage('assets/images/happy_family.png'),
                    height: height * 0.6,
                    // width: 500,
                    color: Colors.blue.withOpacity(1),
                    colorBlendMode: BlendMode.color,
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Text(
                              'OgaBliss',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Passion One',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Bridging the Gap between Tenant and Landlord',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: splashController.animate.value ? 0 : 30,
              left: splashController.animate.value ? -130 : 0,
              child: Image.asset(
                'assets/images/rock.png',
                color: Colors.white.withOpacity(0.8),
                // colorBlendMode: BlendMode.color,
                height: 250,
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: splashController.animate.value ? 80 : -90,
              left: splashController.animate.value ? 30 : -50,
              child: Image.asset(
                'assets/images/key.png',
                // color: Colors.blue.withOpacity(1),
                // colorBlendMode: BlendMode.color,
                height: 250,
                width: 150,
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1500),
              top: splashController.animate.value ? 80 : 40,
              right: splashController.animate.value ? 0 : -10,
              child: Transform.rotate(
                angle: 0.5,
                child: Image.asset(
                  'assets/images/home_o.png',
                  color: Colors.white.withOpacity(1),
                  // colorBlendMode: BlendMode.color,
                  height: 250,
                  width: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}