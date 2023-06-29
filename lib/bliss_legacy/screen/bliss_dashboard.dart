import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/bliss_downline_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_widget/clipper_object.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_downline.dart';
import 'package:oga_bliss/bliss_legacy/screen/bliss_earning.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/currency_formatter.dart';
import '../bliss_controller/account_report_controller.dart';
import '../bliss_controller/bliss_transaction_controller.dart';

class BlissDashboard extends StatefulWidget {
  const BlissDashboard({Key? key}) : super(key: key);

  @override
  State<BlissDashboard> createState() => _BlissDashboardState();
}

class _BlissDashboardState extends State<BlissDashboard> {
  final blissTransactionController = BlissTransactionController().getXID;
  final accountReportController = AccountReportController().getXID;
  final blissDownlineController = BlissDownlineController().getXID;

  late ScrollController _controller;

  String? user_id;
  String? user_name;
  String? user_status;
  bool? admin_status;
  bool? isUserLogin;
  String? image_name;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var userName1 = prefs.getString('user_name');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isUserLogin1 = prefs.getBool('isUserLogin');
    var image_name1 = prefs.getString('image_name');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_name = userName1;
        user_status = user_status1;
        admin_status = admin_status1;
        isUserLogin = isUserLogin1;
        image_name = image_name1;
      });

      await blissTransactionController.fetchTransaction(
          1, user_id, admin_status);

      await accountReportController.getCounters(
          user_id, admin_status, user_status);
      await blissDownlineController.getUsers('1', user_id);
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
    //_controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      blissTransactionController.fetchTransactionMore(
          current_page, user_id, admin_status);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  List _imgs = [];
  final List _localImg = [
    'assets/images/avatar2.jpg',
    'assets/images/avatar1.jpg'
  ];

  getDownlines() {
    _imgs.clear();
    for (var i = 0; i < blissDownlineController.usersList.length; i++) {
      _imgs.add(blissDownlineController.usersList[i].agentImageName);
    }

    if (_imgs.isEmpty) {
      return const Align(
        alignment: Alignment.topLeft,
        child: Text(
          'You have no Downline at the moment',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 15),
      // parent row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < _imgs.length; i++)
            Align(
              widthFactor: 0.8,
              // parent circle avatar.
              // We defined this for better UI
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.shade900,
                // Child circle avatar
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: NetworkImage(_imgs[i]),
                ),
              ),
            )
        ],
      ),
    );
  }

  getCounters() {
    return Obx(
      () => Container(
        width: 300,
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: accountReportController.accountStatusCounter.length,
          itemBuilder: (BuildContext context, int index) {
            var data = accountReportController.accountStatusCounter[index];

            var pBalance = data.payableBalance.toString();

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payable Balance:',
                  style: TextStyle(
                    // fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: (pBalance != null)
                        ? Text(
                            CurrencyFormatter.getCurrencyFormatter(
                              amount: pBalance,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : const Text(
                            'xxxxx',
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('$image_name'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${'Welcome $user_name'},',
                        style: const TextStyle(
                            // fontSize: 15,
                            ),
                      ),
                      Obx(() => (accountReportController
                              .accountStatusCounter.isEmpty)
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blue,
                                size: 30,
                              ),
                            )
                          : getCounters()),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0.0, 10.0),
                              blurRadius: 20.0,
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: FractionalOffset.centerLeft,
                        child: const Image(
                          image: AssetImage(
                            'assets/images/bank_note.png',
                          ),
                          height: 200,
                          width: 190,
                          // color: Colors.blue,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 160.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 0, bottom: 2, right: 10),
                              child: Text(
                                'Start Investing In Real Estate Today',
                                style: TextStyle(
                                  color: Colors.blue.shade600,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'BlackOpsOne',
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const BlissEarning());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 10),
                                child: Container(
                                  height: 40.0,
                                  width: 160.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue.shade900,
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: Center(
                                    child: RichText(
                                      text: const TextSpan(
                                        text: 'Start Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.chevron_right_outlined,
                                              color: Colors.white,
                                            ),
                                            alignment:
                                                PlaceholderAlignment.middle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlissClipperObject(),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Downline',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => const BlissDownline());
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_outlined,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(() => (blissDownlineController.isBUProcessing.value ==
                              'null')
                          ? Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: Colors.blue,
                                size: 30,
                              ),
                            )
                          : getDownlines()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Recent Transaction',
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
                        () => (blissTransactionController
                                    .isBlissTransactionProcessing.value ==
                                'null')
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              )
                            : getTransaction(),
                      ),
                    ],
                  ),
                  Obx(
                    () => (blissTransactionController.transactionList.isEmpty)
                        ? const SizedBox(
                            height: 80,
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => (blissTransactionController.transactionList.isNotEmpty)
            ? Container()
            : InkWell(
                onTap: () {
                  setState(() {
                    blissTransactionController
                        .isBlissTransactionProcessing.value = 'null';
                    blissTransactionController.fetchTransaction(
                        1, user_id, admin_status);
                    blissTransactionController.transactionList.refresh();
                  });
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.blue.shade900,
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  getTransaction() {
    return Obx(
      () => (blissTransactionController.transactionList.isEmpty)
          ? const ShowNotFound()
          : ListView.builder(
              padding: const EdgeInsets.only(top: 0, bottom: 120),
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: blissTransactionController.transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = blissTransactionController.transactionList[index];

                return blissTransactionWidget(
                  amount: data.disAmount.toString(),
                  desc: data.description.toString(),
                  status: data.disStatus.toString(),
                );
              },
            ),
    );
  }
}

class blissTransactionWidget extends StatelessWidget {
  const blissTransactionWidget({
    Key? key,
    required this.amount,
    required this.desc,
    required this.status,
  }) : super(key: key);

  final String amount;
  final String desc;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          CurrencyFormatter.getCurrencyFormatter(
            amount: amount,
          ),
        ),
        subtitle: Text(
          desc,
        ),
        leading: (status == 'pending' || status == 'cancel')
            ? Icon(
                Icons.dark_mode,
                color: Colors.blue.shade500,
              )
            : Icon(
                Icons.dark_mode,
                color: Colors.blue.shade900,
              ),
      ),
    );
  }
}

shortenMoney(String amount) {
  if (amount.length <= 2) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 3) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 5) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 7) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 45,
      ),
      textAlign: TextAlign.center,
    );
  } else if (amount.length <= 9) {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  } else {
    return Text(
      CurrencyFormatter.getCurrencyFormatter(amount: amount),
      style: const TextStyle(
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    );
  }
}
