import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/count_subscription_item_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/subscription_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/subscription_list_model.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:oga_bliss/widget/property_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'land_transaction.dart';

class ManageUserSubscription extends StatefulWidget {
  const ManageUserSubscription({required this.data});

  final MyPlanList data;

  @override
  State<ManageUserSubscription> createState() => _ManageUserSubscriptionState();
}

class _ManageUserSubscriptionState extends State<ManageUserSubscription> {
  final subscriptionController = SubscriptionController().getXID;
  final countSubscriptionItemController =
      CountSubscriptionItemController().getXID;

  String? user_id;
  String? user_name;
  String? user_status;
  String? full_name;
  bool? admin_status;
  bool? isUserLogin;

  String? payableBalance;
  String? totalBalance;
  String? desc;
  bool isLoading = false;
  bool isCardLoading = false;

  late ScrollController _controller;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var userName1 = prefs.getString('user_name');
    var fullName1 = prefs.getString('full_name');
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
        full_name = fullName1;
      });

      await subscriptionController.getUserCardActivities(
          1, widget.data.planId, widget.data.userId);

      await countSubscriptionItemController.getUserCountSubscriptionItems(
        widget.data.userId,
        widget.data.planId,
      );
    }
  }

  var current_page = 1;
  bool widgetLoading = true;

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

      subscriptionController.getUserCardActivitiesMore(
          current_page, widget.data.planId, widget.data.userId);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  getCounters() {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            countSubscriptionItemController.userSubscriptionItemCounter.length,
        itemBuilder: (BuildContext context, int index) {
          var data = countSubscriptionItemController
              .userSubscriptionItemCounter[index];

          return Column(
            children: [
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade900,
                title: 'Total Amount',
                value: '${data.revenueAmount}',
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade900,
                title: 'Number of Successful Debiting',
                isNaira: false,
                value: '${data.successfulDebitting}',
                icon: const Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade900,
                title: 'Number of Failed Debiting',
                isNaira: false,
                value: '${data.countSubscriptionFailed}',
                icon: const Icon(
                  Icons.trending_down,
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
    var data = widget.data;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      '${data.planInterval} Plan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  getCounters(),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Card Transaction Activities',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const LandTransaction());
                            },
                            child: Row(
                              children: const [
                                // Text(
                                //   'View All',
                                //   style: TextStyle(
                                //     color: Colors.blue,
                                //   ),
                                // ),
                                // Icon(
                                //   Icons.chevron_right_outlined,
                                //   color: Colors.blue,
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => ListView.builder(
                          padding: const EdgeInsets.only(top: 0, bottom: 120),
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: subscriptionController
                              .userCardActivitiesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var fata = subscriptionController
                                .userCardActivitiesList[index];

                            // String paidDate = DateFormat('EEEE, MMM d, yyyy')
                            //     .format(fata.paidDate!);

                            return Card(
                              child: ListTile(
                                title: Text(
                                  CurrencyFormatter.getCurrencyFormatter(
                                    amount: fata.amount!,
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      fata.description!,
                                    ),
                                    Text(fata.paidDate!),
                                  ],
                                ),
                                leading: Icon(
                                  Icons.dark_mode,
                                  color: (fata.status == 'success')
                                      ? Colors.blue.shade900
                                      : Colors.blue.shade300,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
