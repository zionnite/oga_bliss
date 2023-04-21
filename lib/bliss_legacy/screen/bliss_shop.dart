import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/shop_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/clipper_object.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/shop_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlissShop extends StatefulWidget {
  const BlissShop({Key? key}) : super(key: key);

  @override
  State<BlissShop> createState() => _BlissShopState();
}

class _BlissShopState extends State<BlissShop> {
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

      await shopController.getPlans(1, user_id);
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

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      shopController.getPlansMore(current_page, user_id);

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
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      'Shop with Bliss Legacy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  BlissClipperObject(
                    marginVal: 0,
                  ),
                  Obx(() => ListView.builder(
                        padding: const EdgeInsets.only(top: 0, bottom: 20),
                        shrinkWrap: true,
                        itemCount: shopController.plansList.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          var data = shopController.plansList[index];
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
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
