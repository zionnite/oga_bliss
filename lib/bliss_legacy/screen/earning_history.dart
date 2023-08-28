import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/account_report_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/point_controller.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EarningHistory extends StatefulWidget {
  const EarningHistory({Key? key}) : super(key: key);

  @override
  State<EarningHistory> createState() => _EarningHistoryState();
}

class _EarningHistoryState extends State<EarningHistory> {
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

      await pointItemController.getMyPointItem(1, user_id);
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

      pointItemController.getMyPointItemMore(1, user_id);

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
                    'Earning History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                //getCounters(),

                SizedBox(
                  height: 5,
                ),
              ],
            ),
            Obx(
              () =>
                  (pointItemController.isMyPointItemProcessing.value == 'null')
                      ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.blue,
                            size: 30,
                          ),
                        )
                      : getData(),
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

  getData() {
    return Obx(
      () => (pointItemController.myPointItemList.isEmpty)
          ? const ShowNotFound()
          : ListView.builder(
              padding:
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 80),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: pointItemController.myPointItemList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = pointItemController.myPointItemList[index];

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
                                image: NetworkImage(data.downlineImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            data.downlineFullName!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                '${data.point!} Point',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              (data.status == 'not_claim')
                                  ? const Text(
                                      'Pending',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    )
                                  : const Text(
                                      'Claimed',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                      ),
                                    ),
                            ],
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
