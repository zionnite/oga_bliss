import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/screen/add_prop_page.dart';
import 'package:oga_bliss/screen/view_my_product.dart';
import 'package:oga_bliss/screen/view_propert_detailed_dash.dart';
import 'package:oga_bliss/widget/property_btn.dart';

import '../controller/property_controller.dart';
import '../model/property_model.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/property_tile_widget.dart';
import 'edit_basic_detail.dart';
import 'edit_extra_detail.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ProductPropertyPage extends StatefulWidget {
  const ProductPropertyPage({Key? key}) : super(key: key);

  @override
  State<ProductPropertyPage> createState() => _ProductPropertyPageState();
}

class _ProductPropertyPageState extends State<ProductPropertyPage> {
  final propsController = PropertyController().getXID;
  late ScrollController _controller;

  final GlobalKey _menuKey = GlobalKey();

  SampleItem? selectedMenu;

  var user_id = 1;
  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = propsController.isDataProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(new Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          checkIfListLoaded();
        });
      }
    });

    // propsController.getDetails(1);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      propsController.getMoreDetail(current_page, user_id);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

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
                    onTap: () {},
                  ),
                  Obx(
                    () => ListView.builder(
                      key: const PageStorageKey<String>('myProperty'),
                      physics: const ClampingScrollPhysics(),
                      // itemExtent: 350,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: propsController.myPropertyList.length,

                      itemBuilder: (BuildContext context, int index) {
                        var props = propsController.myPropertyList[index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                              () => ViewPropertyDetailedDashboard(
                                propsId: props.propsId!,
                                route: 'dashboard',
                              ),
                            );
                          },
                          child: PropertyTileWidget(
                            props_image_name: props.propsImgName!,
                            props_name: props.propsName!,
                            props_desc: props.propsDescription!,
                            props_price: '${props.propsPrice}',
                            props_type: props.propsPurpose!,
                            props_bedroom: props.propsBedrom!,
                            props_bathroom: props.propsBathroom!,
                            props_toilet: props.propsToilet!,
                            onTap: _popUpButton(props),
                          ),
                        );
                      },
                    ),
                  )
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

  Widget _popUpButton(PropertyModel props) {
    return PopupMenuButton<String>(
      enabled: true,
      icon: const Icon(
        Icons.more_vert_rounded,
      ),
      onSelected: (val) {
        if (val == 'submit') {
          print('submit enable');
        } else if (val == 'edit') {
          Get.bottomSheet(
            Container(
              height: 520,
              color: Colors.white,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Edit Property',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Passion One',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  propertyBtn(
                    onTap: () {
                      Get.to(() => EditBasicDetail(model: props));
                    },
                    title: 'Edit Basic Detail',
                    bgColor: Colors.green,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                  propertyBtn(
                    onTap: () {
                      Get.to(() => EditExtraDetail(model: props));
                    },
                    title: 'Edit Extra Details',
                    bgColor: Colors.blue,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                  propertyBtn(
                    onTap: () {},
                    title: 'Edit Amenities',
                    bgColor: Colors.orange,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                  propertyBtn(
                    onTap: () {},
                    title: 'Edit Facilities',
                    bgColor: Colors.black,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                  propertyBtn(
                    onTap: () {},
                    title: 'Edit Valuation',
                    bgColor: Colors.red,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          );
          print('edit');
        } else if (val == 'delete') {
          print('delete');
        } else if (val == 'image') {
          Get.to(() => ViewMyProduct(model: props));
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: "submit",
            child: Text('Submit'),
          ),
          const PopupMenuItem(
            value: "image",
            child: Text('View Image'),
          ),
          const PopupMenuItem(
            value: "edit",
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: "delete",
            child: Text('Delete'),
          ),
        ];
      },
    );
  }
}
