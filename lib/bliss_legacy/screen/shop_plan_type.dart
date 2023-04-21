import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/shop_controller.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bliss_widget/shop_widget.dart';

class ShopPlanType extends StatefulWidget {
  ShopPlanType({required this.planId});

  final String planId;

  @override
  State<ShopPlanType> createState() => _ShopPlanTypeState();
}

class _ShopPlanTypeState extends State<ShopPlanType> {
  final shopController = ShopController().getXID;

  late ScrollController _controller;

  String? user_id;
  String? user_name;
  String? user_status;
  bool? admin_status;
  bool? isUserLogin;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var userName1 = prefs.getString('user_name');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isUserLogin1 = prefs.getBool('isUserLogin');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_name = userName1;
        user_status = user_status1;
        admin_status = admin_status1;
        isUserLogin = isUserLogin1;

        //TODO: COME HERE AND DELETE THIS
        user_id = '1';
        admin_status = false;
      });

      if (widget.planId == 'building' || widget.planId == 'land') {
        await shopController.getDisPlansType(1, widget.planId, user_id);
      } else {
        await shopController.getDisPlansInterval(1, widget.planId, user_id);
      }
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;
  String? payableBalance;

  @override
  void initState() {
    initUserDetail();
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });
      print('Scroolsup');

      if (widget.planId == 'building' || widget.planId == 'land') {
        await shopController.getDisPlansTypeMore(1, widget.planId, user_id);
      } else {
        await shopController.getDisPlansIntervalMore(1, widget.planId, user_id);
      }

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  getPlanName(String planId) {
    if (planId == 'building') {
      return 'Building Plan';
    } else if (planId == 'land') {
      return 'Land Plan';
    } else if (planId == 'daily') {
      return 'Daily Plan';
    } else if (planId == 'weekly') {
      return 'Weekly Plan';
    } else if (planId == 'monthly') {
      return 'Monthly Plan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(35),
                    ),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      getPlanName(widget.planId),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Obx(() =>
                      (shopController.isShopIntervalProcessing.value == 'null')
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blue,
                                size: 20,
                              ),
                            )
                          : getData()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getData() {
    return (shopController.disPlansList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (widget.planId == 'building' ||
                        widget.planId == 'land') {
                      shopController.isShopIntervalProcessing.value = 'null';
                      shopController.getDisPlansType(1, widget.planId, user_id);
                      shopController.disPlansList.refresh();
                    } else {
                      shopController.isShopIntervalProcessing.value = 'null';
                      shopController.getDisPlansInterval(
                          1, widget.planId, user_id);
                      shopController.disPlansList.refresh();
                    }
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ])
        : Obx(
            () => ListView.builder(
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              shrinkWrap: true,
              itemCount: shopController.disPlansList.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var data = shopController.disPlansList[index];
                return shopWidget(
                  onTap: () {
                    print('this clicked');
                  },
                  planImg: '${data.planImage}',
                  planName: '${data.planName}',
                  planInterval: '${data.planInterval}',
                  planLimit: '${data.planLimit}',
                  planAmount: '${data.planAmount}',
                );
              },
            ),
          );
  }
}
