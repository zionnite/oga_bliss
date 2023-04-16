import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';

class BlissProfile extends StatefulWidget {
  const BlissProfile({Key? key}) : super(key: key);

  @override
  State<BlissProfile> createState() => _BlissProfileState();
}

class _BlissProfileState extends State<BlissProfile> {
  int _currentPage = 0;
  Color bgColor = Colors.green;
  int visit = 0;
  Color color2 = Colors.blue;
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
    const TabItem(
      icon: Icons.account_box,
      title: 'Log',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text(
                'Profile Page',
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            BottomBarInspiredOutside(
              items: items,
              backgroundColor: Colors.blue,
              color: Colors.red,
              colorSelected: Colors.white,
              indexSelected: _currentPage,
              onTap: (int index) => setState(() {
                _currentPage = index;
              }),
              top: -25,
              animated: true,
              itemStyle: ItemStyle.hexagon,
              chipStyle: const ChipStyle(drawHexagon: true),
            ),
            SizedBox(
              height: 40,
            ),
            BottomBarFloating(
              items: items,
              backgroundColor: bgColor,
              color: color2,
              colorSelected: Colors.white,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(
              height: 40,
            ),
            BottomBarCreative(
              isFloating: true,
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color2,
              colorSelected: Colors.black,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(
              height: 40,
            ),
            BottomBarCreative(
              isFloating: true,
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color2,
              colorSelected: Colors.black,
              indexSelected: visit,
              highlightStyle: const HighlightStyle(
                isHexagon: true,
              ),
              onTap: (int index) => setState(() {
                visit = index;
              }),
            ),
            SizedBox(height: 10),
            BottomBarCreative(
              items: items,
              backgroundColor: Colors.green.withOpacity(0.21),
              color: color2,
              colorSelected: Colors.black,
              indexSelected: visit,
              isFloating: true,
              highlightStyle: const HighlightStyle(
                sizeLarge: true,
                isHexagon: true,
                elevation: 12,
              ),
              onTap: (int index) => setState(
                () {
                  visit = index;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
