import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/screen/add_prop_page.dart';
import 'package:oga_bliss/screen/view_my_product.dart';
import 'package:oga_bliss/screen/view_propert_detailed_dash.dart';
import 'package:oga_bliss/widget/property_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import '../model/property_model.dart';
import '../util/common.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/property_tile_widget.dart';
import '../widget/show_not_found.dart';
import 'edit_amenities.dart';
import 'edit_basic_detail.dart';
import 'edit_extra_detail.dart';
import 'edit_facilities.dart';
import 'edit_valuation.dart';

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

  String? user_id;
  String? user_status;
  bool? admin_status;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = user_status1;
        admin_status = admin_status1;
      });
    }
  }

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
    initUserDetail();
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          checkIfListLoaded();
        });
      }
    });
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
            child: (widgetLoading)
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blue,
                    size: 20,
                  )
                : (propsController.myPropertyList.isEmpty)
                    ? const Center(child: ShowNotFound())
                    : SingleChildScrollView(
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
                                itemCount:
                                    propsController.myPropertyList.length,

                                itemBuilder: (BuildContext context, int index) {
                                  var props =
                                      propsController.myPropertyList[index];

                                  if (propsController
                                          .myPropertyList[index].propsId ==
                                      null) {
                                    return Container();
                                  }
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
                                      live_status:
                                          props.propsLiveStatus.toString(),
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
      onSelected: (val) async {
        if (val == 'submit') {
          if (props.propsLiveStatus == 'new' ||
              props.propsLiveStatus == 'rejected') {
            bool status = await propsController.submitProperty(props.propsId);
            setState(() {
              int index = propsController.myPropertyList.indexOf(props);
              propsController.myPropertyList[index].propsLiveStatus = 'pending';
              propsController.myPropertyList.refresh();
            });
          }
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
                    onTap: () {
                      Get.to(() => EditAmenities(model: props));
                    },
                    title: 'Edit Amenities',
                    bgColor: Colors.orange,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                  propertyBtn(
                    onTap: () {
                      Get.to(() => EditFacilities(model: props));
                    },
                    title: 'Edit Facilities',
                    bgColor: Colors.black,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                  propertyBtn(
                    onTap: () {
                      Get.to(() => EditValuation(model: props));
                    },
                    title: 'Edit Valuation',
                    bgColor: Colors.red,
                    card_margin: const EdgeInsets.all(10),
                    container_margin: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          );
        } else if (val == 'delete') {
          bool status = await propsController.deleteProperty(props.propsId);
          if (status) {
            setState(() {
              int rootIndex = propsController.myPropertyList.indexOf(props);
              propsController.myPropertyList.removeAt(rootIndex);
            });
          }
        } else if (val == 'image') {
          Get.to(
              () => ViewMyProduct(model: props, user_id: user_id.toString()));
        } else if (val == 'already') {
          showSnackBar(
            title: 'Property',
            msg: 'Your Property status its ${props.propsLiveStatus}',
            backgroundColor: Colors.blue,
          );
        }
      },
      itemBuilder: (context) {
        return [
          (props.propsLiveStatus == 'new' ||
                  props.propsLiveStatus == 'rejected')
              ? const PopupMenuItem(
                  value: "submit",
                  child: Text('Submit'),
                )
              : const PopupMenuItem(
                  value: "already",
                  child: Text('Already Submitted'),
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
