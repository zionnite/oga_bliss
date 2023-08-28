import 'package:flutter/material.dart';

class ShowNotFound extends StatelessWidget {
  const ShowNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.only(
                    top: 5, left: 10, right: 10, bottom: 10),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/not_found.png',
                        height: 290,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Could not Fetch Data, below are reasons you are seeing this',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Passion One',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        '1) There is no  data to fetch from database',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Passion One',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        '2) Your Internet it\'s weak',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Passion One',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
