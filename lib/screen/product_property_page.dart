import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/screen/add_prop_page.dart';
import 'package:oga_bliss/util/currency_formatter.dart';

import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/property_tile_widget.dart';

class ProductPropertyPage extends StatefulWidget {
  const ProductPropertyPage({Key? key}) : super(key: key);

  @override
  State<ProductPropertyPage> createState() => _ProductPropertyPageState();
}

class _ProductPropertyPageState extends State<ProductPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Property'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  PropertyTileWidget(
                    props_image_name:
                        'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                    props_name: 'Newly Built 3 Bedroom flat',
                    props_desc:
                        'this newly built bedroom flat its covered with the latest and later type of euqipment that will keep your day going well',
                    props_price: '90000000000000',
                    props_type: 'Buy',
                    props_bedroom: '100',
                    props_bathroom: '290',
                    props_toilet: '100',
                    onTap: () {
                      print('am clicked');
                    },
                  ),
                  PropertyTileWidget(
                    props_image_name:
                        'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                    props_name: 'Newly Built 3 Bedroom flat',
                    props_desc:
                        'this newly built bedroom flat its covered with the latest and later type of euqipment that will keep your day going well',
                    props_price: '90000000000000',
                    props_type: 'Rent',
                    props_bedroom: '100',
                    props_bathroom: '290',
                    props_toilet: '100',
                    onTap: () {
                      print('am clicked');
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => AddPropertyPage(),
            transition: Transition.upToDown,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
