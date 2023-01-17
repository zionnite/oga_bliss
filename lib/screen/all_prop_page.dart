import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/property_controller.dart';
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
  final propsController = PropertyController();

  @override
  void initState() {
    super.initState();
    propsController.getDetails(1);
  }

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
                  child: Obx(
                    () => ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      // itemExtent: 350,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: propsController.propertyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var props = propsController.propertyList[index];
                        return PropertyWidget(
                          props_image: props.propsImgName!,
                          props_name: props.propsName!,
                          props_type: 'buy',
                          props_price: props.propsPrice!,
                          isFav: props.favourite!,
                          props_bedroom: '1',
                          props_bathroom: '3',
                          props_toilet: '5',
                          props_image_counter: '10',
                        );
                      },
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
