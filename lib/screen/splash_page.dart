import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Positioned(
            top: 110,
            right: 0,
            left: 0,
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
                      children: const [
                        Text(
                          'OgaBliss',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Passion One',
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Bridging the Gap between Tenant and Landlord',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: -130,
            child: Image.asset(
              'assets/images/rock.png',
              color: Colors.white.withOpacity(0.8),
              // colorBlendMode: BlendMode.color,
              height: 250,
            ),
          ),
          Positioned(
            top: 80,
            left: 30,
            child: Image.asset(
              'assets/images/key.png',
              // color: Colors.blue.withOpacity(1),
              // colorBlendMode: BlendMode.color,
              height: 250,
              width: 150,
            ),
          ),
          Positioned(
            top: 80,
            right: 0,
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
        ],
      ),
    );
  }
}
