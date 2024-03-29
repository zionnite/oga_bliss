import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_downline.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_plan.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_profile.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_shop.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/not_login_page.dart';
import 'screen/bliss_dashboard.dart';

class BlissHome extends StatefulWidget {
  const BlissHome({Key? key}) : super(key: key);

  @override
  State<BlissHome> createState() => _BlissHomeState();
}

class _BlissHomeState extends State<BlissHome> {
  int _currentPage = 0;
  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.shopping_cart,
      title: 'Shop',
    ),
    const TabItem(
      icon: Icons.card_giftcard,
      title: 'Plans',
    ),
    const TabItem(
      icon: Icons.account_tree_sharp,
      title: 'Downline',
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'profile',
    ),
  ];

  String? user_id;
  String? user_status;
  bool? admin_status;
  bool? guestStatus;
  bool? loginStatus;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempLoginStatus = prefs.getBool("tempLoginStatus");

    if (tempLoginStatus == true) {
      prefs.remove("tempLoginStatus");
    }

    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isGuestLogin = prefs.getBool('isGuestLogin');
    var isUserLogin = prefs.getBool('isUserLogin');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
        guestStatus = isGuestLogin;
        loginStatus = isUserLogin;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (newIndex) {
              setState(() {
                _currentPage = newIndex;
              });
            },
            children: [
              const BlissDashboard(),
              const BlissShop(),
              const BlissPlan(),
              const BlissDownline(),
              // BlissProfile(),
              ProfileToView(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomBarCreative(
          top: 12,
          bottom: 12,
          pad: 4,
          items: items,
          backgroundColor: Colors.white,
          color: Colors.black,
          colorSelected: Colors.blue.shade900,
          indexSelected: _currentPage,
          isFloating: true,
          highlightStyle: const HighlightStyle(
            sizeLarge: true,
            isHexagon: true,
            elevation: 12,
          ),
          onTap: (index) => setState(
            () {
              pageController.animateToPage(
                index,
                duration: const Duration(microseconds: 500),
                curve: Curves.bounceIn,
              );
            },
          ),
        ),
        // BottomBarInspiredOutside(
        //   items: items,
        //   backgroundColor: Colors.blue.shade900,
        //   color: Colors.white,
        //   colorSelected: Colors.white,
        //   indexSelected: _currentPage,
        //   onTap: (index) => setState(
        //         () {
        //       pageController.animateToPage(
        //         index,
        //         duration: const Duration(microseconds: 500),
        //         curve: Curves.bounceIn,
        //       );
        //     },
        //   ),
        //   top: -25,
        //   animated: true,
        //   itemStyle: ItemStyle.hexagon,
        //   chipStyle: const ChipStyle(drawHexagon: true),
        // ),
      ),
    );
  }

  Widget ProfileToView() {
    if (loginStatus != null) {
      return const ProfilePage();
    } else {
      return const NotLoginPage();
    }
  }
}

shortenMoney(String amount) {
  if (amount.length <= 2) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 3) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 5) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 7) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 45,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 9) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class CustomClipper extends StatelessWidget {
  const CustomClipper({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 100,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue.shade900,
        border: Border.all(
          color: Colors.blue,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
