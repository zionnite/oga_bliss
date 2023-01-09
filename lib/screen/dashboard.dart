import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/home_page.dart';

import '../util/currency_formatter.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
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
      body: Column(
        children: [
          const PropertyAppBar(title: 'Dashboard'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const propertyCard(
                    bgColor1: Colors.red,
                    bgColor2: Colors.orange,
                    title: 'Total Earning',
                    value: '500000000',
                    icon: Icon(
                      Icons.wallet,
                      color: Colors.white,
                      size: 30,
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
                      size: 30,
                    ),
                  ),
                  const propertyCard(
                    bgColor1: Colors.black54,
                    bgColor2: Colors.black,
                    title: 'Total Property',
                    value: '500000000',
                    isNaira: false,
                    icon: Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                      size: 30,
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
                      size: 30,
                    ),
                  ),
                  propertyCard(
                    bgColor1: Colors.orange,
                    bgColor2: Colors.orange.shade400,
                    title: 'Total Connection',
                    value: '10',
                    isNaira: false,
                    icon: const Icon(
                      Icons.people_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  NoticeMe(
                    title: 'Oops!',
                    desc: 'Your bank account is not yet verify!',
                    icon: Icons.warning,
                    icon_color: Colors.red,
                    border_color: Colors.red,
                    btnTitle: 'Verify Now',
                    btnColor: Colors.blue,
                    onTap: () {
                      print('click');
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
