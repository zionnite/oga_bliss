import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Image.asset(
            //   'assets/images/family.jpg',
            //   height: height * 0.5,
            // ),

            //////
            // Container(
            //   height: height * 0.5,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.fitWidth,
            //       image: AssetImage(
            //         'assets/images/family.jpg',
            //       ),
            //     ),
            //   ),
            // ),
            ////////////////
            // const CircleAvatar(
            //   radius: 50,
            //   backgroundImage: AssetImage('assets/images/family.jpg'),
            // ),
            Stack(
              children: [
                Container(
                  color: Colors.red,
                ),
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
              ],
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
          ],
        ),
      ),
    );
  }
}
