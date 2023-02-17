import 'dart:io';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:oga_bliss/screen/favourite.dart';
import 'package:oga_bliss/screen/not_login_page.dart';
import 'package:oga_bliss/screen/not_user_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/property_controller.dart';
import 'screen/all_prop_page.dart';
import 'screen/profile_page.dart';
import 'screen/search_alone_page.dart';
import 'widget/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PropertyController propsController = PropertyController();
  int _currentPage = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);

  int android = 30;
  int ios = 30;

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

  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.search_sharp,
      title: 'Search',
    ),
    const TabItem(
      icon: Icons.favorite_outlined,
      title: 'Favourite',
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'profile',
    ),
  ];

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: 0);

    return Scaffold(
      key: _key,
      drawer: NavigationDrawerWidget(),
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
              AllPropertyPage(
                s_key: _key,
              ),
              const SearchAlonePage(),
              FavouriteToView(),
              // RentPropertyPage(),
              ProfileToView()
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: (Platform.isAndroid) ? 90 : 95,
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
              margin: (Platform.isAndroid)
                  ? const EdgeInsets.only(
                      top: 0,
                      bottom: 20,
                      right: 30,
                      left: 30,
                    )
                  : const EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                      right: 30,
                      left: 30,
                    ),
              child: BottomBarSalomon(
                // titleStyle: TextStyle(fontSize: 20),
                bottom: 0,
                top: Platform.isAndroid ? 10 : 35,
                iconSize: 28,
                items: items,
                color: Colors.blue,
                animated: true,
                heightItem: 40,
                // radiusSalomon: BorderRadius.circular(3),
                backgroundColor: Colors.white,
                colorSelected: Colors.white,
                backgroundSelected: Colors.blue,
                borderRadius: BorderRadius.circular(9),
                indexSelected: _currentPage,
                onTap: (index) => setState(() {
                  pageController.animateToPage(
                    index,
                    duration: Duration(microseconds: 500),
                    curve: Curves.bounceIn,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget FavouriteToView() {
    if (user_status == 'user') {
      return const FavouritePage();
    } else {
      return const NotUserPage();
    }
  }

  Widget ProfileToView() {
    if (loginStatus != null) {
      return const ProfilePage();
    } else {
      return const NotLoginPage();
    }
  }
}
