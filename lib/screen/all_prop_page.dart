import 'package:flutter/material.dart';

import '../widget/navigation_drawer.dart';
import '../widget/property_widget.dart';
import '../widget/search_widget.dart';

class AllPropertyPage extends StatefulWidget {
  const AllPropertyPage({required this.s_key});
  final GlobalKey<ScaffoldState> s_key;
  @override
  State<AllPropertyPage> createState() => _AllPropertyPageState();
}

class _AllPropertyPageState extends State<AllPropertyPage> {
  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      // drawer: NavigationDrawerWidget(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 450,
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 39,
                      ),
                      onPressed: () {
                        // Scaffold.of(context).openDrawer();
                        widget.s_key.currentState!.openDrawer();
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(
                          'Find Your Dream',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Passion One',
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lobster',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SearchWidget(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 350,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, right: 20.0, left: 20.0, bottom: 120),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    // itemExtent: 350,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      PropertyWidget(
                        props_image:
                            'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                        props_name: 'Newly Built House',
                        props_type: 'buy',
                        props_price: '10000000',
                        isFav: false,
                        props_bedroom: '1',
                        props_bathroom: '3',
                        props_toilet: '5',
                        props_image_counter: '10',
                      ),
                      PropertyWidget(
                        props_image:
                            'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                        props_name: 'Newly Renovated Home of Asernals',
                        props_type: 'rent',
                        props_price: '10000000',
                        isFav: true,
                        props_bedroom: '1',
                        props_bathroom: '3',
                        props_toilet: '5',
                        props_image_counter: '1',
                      ),
                    ],
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
