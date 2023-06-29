import 'package:flutter/material.dart';
import 'package:flutterme_credit_card/flutterme_credit_card.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/count_subscription_item_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/subscription_list_model.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/rounded_button.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/property_card.dart';
import '../bliss_controller/account_report_controller.dart';
import '../bliss_controller/subscription_controller.dart';

class ManageSubscription extends StatefulWidget {
  ManageSubscription({required this.data});
  final MyPlanList data;

  @override
  State<ManageSubscription> createState() => _ManageSubscriptionState();
}

class _ManageSubscriptionState extends State<ManageSubscription> {
  final accountReportController = AccountReportController().getXID;
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
  bool isDisableLoading = false;
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

      await accountReportController.getCounters(
          user_id, admin_status, user_status);

      await subscriptionController.getPlanList(1, user_id);

      await subscriptionController.getCardActivities(
          1, widget.data.planId, user_id);

      await countSubscriptionItemController.getCountSubscriptionItems(
        user_id,
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
      if (mounted) {
        setState(() {
          isLoading = true;
          current_page++;
        });
      }

      subscriptionController.getCardActivitiesMore(
          current_page, widget.data.planId, user_id);

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
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
            countSubscriptionItemController.subscriptionItemCounter.length,
        itemBuilder: (BuildContext context, int index) {
          var data =
              countSubscriptionItemController.subscriptionItemCounter[index];

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
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FMCreditCard(
                    margin: const EdgeInsets.all(0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade900,
                        Colors.blue,
                      ],
                    ),
                    number: '${data.authBin}384736${data.authLast4}',
                    numberMaskType: FMMaskType.first6last2,
                    cvv: '***',
                    cvvMaskType: FMMaskType.full,
                    validThru: '${data.authExpMonth}/${data.authExpYear}',
                    validThruMaskType: FMMaskType.none,
                    holder: '${full_name}',
                    title: 'OgaBliss | Subscription Card',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoundedButton(
                        title: 'Disable Subscription',
                        txtColor: Colors.white,
                        bgColor: Colors.blue.shade900,
                        isLoading: isDisableLoading,
                        onTap: () async {
                          Get.defaultDialog(
                            title: "Action Needed",
                            middleText:
                                "Are you sure you want to disable this subscription?",
                            radius: 5,
                            textConfirm: "Yes, Disable",
                            confirmTextColor: Colors.white,
                            onConfirm: () async {
                              setState(() {
                                isDisableLoading = true;
                                Get.back();
                              });

                              String status = await subscriptionController
                                  .toggleDisableButton(
                                disId: data.id ?? '',
                                userId: user_id ?? '',
                                planId: data.planId ?? '',
                                planCode: data.planCode ?? '',
                                subCode: data.subscriptionCode ?? '',
                                emailToken: data.emailToken ?? '',
                                planList: data,
                              );
                              if (status == 'true_1' ||
                                  status == 'true_2' ||
                                  status == 'false' ||
                                  status == 'false_2') {
                                setState(() {
                                  isDisableLoading = false;
                                  // Get.back();
                                });
                              } else {
                                setState(() {
                                  isDisableLoading = false;
                                });
                                // Get.back();
                              }
                            },
                            textCancel: "No, Cancel",
                            cancelTextColor: Colors.blue.shade900,
                            onCancel: () {},
                          );
                        },
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      RoundedButton(
                        title: 'Update Card',
                        txtColor: Colors.blue,
                        bgColor: Colors.white,
                        isLoading: isCardLoading,
                        isLoadingColor: Colors.blue.shade900,
                        onTap: () async {
                          Get.defaultDialog(
                            title: "Action Needed",
                            middleText:
                                "Are you sure you want to Update Card for this subscription?",
                            radius: 5,
                            textConfirm: "Yes, Update",
                            confirmTextColor: Colors.white,
                            onConfirm: () async {
                              setState(() {
                                isCardLoading = true;
                                Get.back();
                              });

                              String status =
                                  await subscriptionController.updateCard(
                                user_id,
                                data.subscriptionCode,
                              );
                              if (status == 'false_0' ||
                                  status == 'false_1' ||
                                  status == 'false_2' ||
                                  status == 'true') {
                                setState(() {
                                  isCardLoading = false;
                                  // Get.back();
                                });
                              } else {
                                setState(() {
                                  isCardLoading = false;
                                });
                                // Get.back();
                              }
                            },
                            textCancel: "No, Cancel",
                            cancelTextColor: Colors.blue.shade900,
                            onCancel: () {},
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getCounters(),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Card Transaction Activities',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Get.to(() => const LandTransaction());
                          //   },
                          //   child: Row(
                          //     children: const [
                          //       Text(
                          //         'View All',
                          //         style: TextStyle(
                          //           color: Colors.blue,
                          //         ),
                          //       ),
                          //       Icon(
                          //         Icons.chevron_right_outlined,
                          //         color: Colors.blue,
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => (subscriptionController
                                .cardActivitiesList.isEmpty)
                            ? const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Card activities will appear here'),
                              )
                            : getTrans(),
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

  getTrans() {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 120),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: subscriptionController.cardActivitiesList.length,
        itemBuilder: (BuildContext context, int index) {
          var fata = subscriptionController.cardActivitiesList[index];

          // String paidDate = DateFormat('EEEE, MMM d, yyyy')
          //     .format(fata.paidDate!);

          var dateTime = DateTime.parse('${fata.paidDate}');
          String paidDate = DateFormat('EEEE, MMM d, yyyy').format(dateTime);

          return Card(
            child: ListTile(
              title: Text(
                CurrencyFormatter.getCurrencyFormatter(
                  amount: fata.amount!,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fata.description!,
                  ),
                  Text(
                    paidDate,
                    style: const TextStyle(),
                  ),
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
