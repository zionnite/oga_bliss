import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/subscription_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/property_card.dart';
import '../bliss_controller/account_report_controller.dart';
import 'manage_subscription.dart';

class BlissPlan extends StatefulWidget {
  const BlissPlan({Key? key}) : super(key: key);

  @override
  State<BlissPlan> createState() => _BlissPlanState();
}

class _BlissPlanState extends State<BlissPlan> {
  final accountReportController = AccountReportController().getXID;
  final subscriptionController = SubscriptionController().getXID;

  String? user_id;
  String? user_name;
  String? user_status;
  bool? admin_status;
  bool? isUserLogin;

  String? payableBalance;
  String? totalBalance;

  late ScrollController _controller;

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

      await accountReportController.getCounters(
          user_id, admin_status, user_status);

      await subscriptionController.getPlanList(1, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  @override
  void initState() {
    initUserDetail();
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (mounted) {
        setState(() {
          isLoading = true;
          current_page++;
        });
      }

      subscriptionController.getPlanListMore(current_page, user_id);

      if (mounted) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        });
      }
    }
  }

  getCounters() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.all(0),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: accountReportController.accountStatusCounter.length,
        itemBuilder: (BuildContext context, int index) {
          var data = accountReportController.accountStatusCounter[index];

          var pBalance = data.payableBalance.toString();
          var pEarned = data.totalBalance.toString();

          return Column(
            children: [
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade900,
                title: 'Total Amount Earned',
                value: '$pEarned',
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade900,
                title: 'Payable Balance',
                value: '$pBalance',
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          );
        },
      ),
    );
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
                    color: Colors.white70,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(35),
                    ),
                    border: Border.all(
                      color: Colors.blue.shade100,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      'Your Plan with Bliss Legacy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() =>
                      (accountReportController.accountStatusCounter.isEmpty)
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blue,
                                size: 30,
                              ),
                            )
                          : getCounters()),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'List Plan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() =>
                      (subscriptionController.isMyPlaProcessing.value == 'null')
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blue,
                                size: 30,
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
    return (subscriptionController.myPlanList.isEmpty)
        ? const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Your Plan will appear yer',
              ),
            ),
          )
        : Obx(
            () => ListView.builder(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: subscriptionController.myPlanList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = subscriptionController.myPlanList[index];
                String startDate =
                    DateFormat('EEEE, MMM d, yyyy').format(data.subStartDate!);
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => ManageSubscription(
                        data: data,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(data.planImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            data.planName!,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            startDate,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
