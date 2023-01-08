import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/home_page.dart';

import '../util/currency_formatter.dart';
import '../widget/property_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(color: Colors.blue.shade600),
                  child: SizedBox(),
                ),
                Positioned(
                  top: 60,
                  left: 15,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        border: Border.all(
                          color: Colors.blue.shade100,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.black54,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 15,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                        border: Border.all(
                          color: Colors.blue.shade100,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.notifications_sharp,
                          color: Colors.black26,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 15,
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: const Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lobster',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const propertyCard(
              bgColor1: Colors.red,
              bgColor2: Colors.orange,
              title: 'Total Earning',
              value: '500000000',
              icon: Icon(
                Icons.wallet,
                color: Colors.white,
                size: 50,
              ),
            ),
            propertyCard(
              bgColor1: Colors.blue,
              bgColor2: Colors.blue.shade400,
              title: 'Wallet Balance',
              value: '500000000',
              icon: const Icon(
                Icons.cases_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),
            propertyCard(
              bgColor1: Colors.green,
              bgColor2: Colors.green.shade400,
              title: 'Total Transaction',
              value: '1',
              isNaira: false,
              icon: const Icon(
                Icons.trending_up_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
