import 'dart:io';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:oga_bliss/screen/favourite.dart';

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
  final propsController = PropertyController();
  int _currentPage = 0;
  double height = 30;
  Color colorSelect = const Color(0XFF0686F8);
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);

  int android = 30;
  int ios = 30;

  @override
  void initState() {
    super.initState();
    propsController.getDetails(1);
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
    PageController _pageController = PageController(initialPage: 0);

    return Scaffold(
      key: _key,
      drawer: NavigationDrawerWidget(),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
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
              const FavouritePage(),
              // RentPropertyPage(),
              const ProfilePage()
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
                  _pageController.animateToPage(
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
}
