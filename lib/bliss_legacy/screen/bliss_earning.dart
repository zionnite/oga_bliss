import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/point_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/rounded_button.dart';
import 'package:oga_bliss/bliss_legacy/screen/earning_history.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bliss_controller/account_report_controller.dart';

class BlissEarning extends StatefulWidget {
  const BlissEarning({Key? key}) : super(key: key);

  @override
  State<BlissEarning> createState() => _BlissEarningState();
}

class _BlissEarningState extends State<BlissEarning> {
  final pointItemController = PointItemController().getXID;
  final accountReportController = AccountReportController().getXID;

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
      });

      await pointItemController.getPointItem(1, user_id);
      await accountReportController.getCounters(
          user_id, admin_status, user_status);
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

      pointItemController.getPointItem(1, user_id);

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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 160.0, top: 20.0, left: 8),
                  child: Text(
                    'Earning',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ),
                //getCounters(),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                  'With Bliss Legacy, you can earn and win, below are item that can be earn and won, You earn by points'),
            ),
            Obx(
              () => (pointItemController.isPointItemProcessing.value == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 30,
                      ),
                    )
                  : itemToEarn(),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                RoundedButton(
                  bgColor: Colors.blue.shade900,
                  txtColor: Colors.white,
                  title: 'View Earning History',
                  onTap: () {
                    Get.to(() => const EarningHistory());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getCounters() {
    return Obx(
      () => SizedBox(
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 8),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: accountReportController.accountStatusCounter.length,
          itemBuilder: (BuildContext context, int index) {
            var data = accountReportController.accountStatusCounter[index];

            return Padding(
              padding: const EdgeInsets.only(right: 0, top: 0, bottom: 10),
              child: Text(
                'Total ${data.countMyPoint.toString()} Point',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
            );
          },
        ),
      ),
    );
  }

  itemToEarn() {
    return Obx(
      () => (pointItemController.pointItemList.isEmpty)
          ? const ShowNotFound()
          : ListView.builder(
              padding:
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: pointItemController.pointItemList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = pointItemController.pointItemList[index];
                return Column(
                  children: [
                    Card(
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(data.pointImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            data.pointName!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            data.point!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
