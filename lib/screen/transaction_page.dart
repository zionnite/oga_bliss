import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  String user_id = '1';
  String user_status = 'user';
  bool admin_status = true;

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = transController.isDataProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);

    Future.delayed(new Duration(seconds: 4), () {
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

      transController.fetchTransactionMore(current_page);

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
          const PropertyAppBar(title: 'Transactions'),
          Expanded(
            child: SingleChildScrollView(
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
                      key: const PageStorageKey<String>('allTransaction'),
                      physics: const ClampingScrollPhysics(),
                      // itemExtent: 350,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: transController.transactionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var trans = transController.transactionList[index];

                        if (trans.disStatus == 'success') {
                          return transactionWidget(
                            leadingIcon: (trans.transType == 'deposit' ||
                                    trans.transType == 'complete_transafer')
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
                            leadingIcon: (trans.transType == 'deposit' ||
                                    trans.transType == 'complete_transafer')
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
                            leadingIcon: (trans.transType == 'deposit' ||
                                    trans.transType == 'complete_transafer')
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
