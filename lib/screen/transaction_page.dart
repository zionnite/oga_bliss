import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/transaction_controller.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/transaction_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final transController = TransactionController().getXID;
  late ScrollController _controller;
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

      await transController.fetchTransaction(1, user_id, admin_status);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = transController.isDataProcessing.value;
    if (loading || !loading) {
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

      transController.fetchTransactionMore(current_page, user_id, admin_status);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  showNotFound() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
            ),
            Image.asset(
              'assets/images/data_not_found.png',
              fit: BoxFit.fitWidth,
            ),
            const Text(
              'Oops!... no data found',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: 'Lobster',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Transactions'),
          Expanded(
            child: (widgetLoading)
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue,
                      size: 20,
                    ),
                  )
                : (transController.transactionList.isEmpty)
                    ? showNotFound()
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
                                controller: _controller,
                                padding: const EdgeInsets.only(bottom: 120),
                                key: const PageStorageKey<String>(
                                    'allTransaction'),
                                physics: const ClampingScrollPhysics(),
                                // itemExtent: 350,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    transController.transactionList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var trans =
                                      transController.transactionList[index];
                                  if (transController
                                          .transactionList[index].id ==
                                      null) {
                                    return Container();
                                  }

                                  if (trans.disStatus == 'success') {
                                    return transactionWidget(
                                      leadingIcon:
                                          (trans.transType == 'deposit' ||
                                                  trans.transType ==
                                                      'complete_transafer')
                                              ? const Icon(
                                                  Icons.trending_up,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
                                                  Icons.trending_down,
                                                  color: Colors.red,
                                                ),
                                      amount: trans.disAmount.toString(),
                                      date: trans.dateCreated.toString(),
                                      trailingIcon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                    );
                                  } else if (trans.disStatus == 'cancel') {
                                    return transactionWidget(
                                      leadingIcon:
                                          (trans.transType == 'deposit' ||
                                                  trans.transType ==
                                                      'complete_transafer')
                                              ? const Icon(
                                                  Icons.trending_up,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
                                                  Icons.trending_down,
                                                  color: Colors.red,
                                                ),
                                      amount: trans.disAmount.toString()!,
                                      date: trans.dateCreated.toString()!,
                                      trailingIcon: const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ),
                                    );
                                  } else {
                                    return transactionWidget(
                                      leadingIcon:
                                          (trans.transType == 'deposit' ||
                                                  trans.transType ==
                                                      'complete_transafer')
                                              ? const Icon(
                                                  Icons.trending_up,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
                                                  Icons.trending_down,
                                                  color: Colors.red,
                                                ),
                                      amount: trans.disAmount.toString()!,
                                      date: trans.dateCreated.toString()!,
                                      trailingIcon: const Icon(
                                        Icons.fiber_manual_record_outlined,
                                        color: Colors.blue,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
