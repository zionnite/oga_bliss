import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/transaction_controller.dart';
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

      transController.fetchTransactionMore(current_page, user_id, admin_status);

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
            child: Obx(
              () => (transController.isTransactionProcessing == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 20,
                      ),
                    )
                  : detail(),
            ),
          )
        ],
      ),
    );
  }

  Widget detail() {
    print('this - ${transController.propsTransactionList}');
    return (transController.propsTransactionList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    transController.isTransactionProcessing.value = 'null';
                    transController.fetchTransaction(1, user_id, admin_status);
                    transController.propsTransactionList.refresh();
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
              controller: _controller,
              padding: const EdgeInsets.only(bottom: 120),
              key: const PageStorageKey<String>('allTransaction'),
              physics: const ClampingScrollPhysics(),
              // itemExtent: 350,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: transController.propsTransactionList.length,
              itemBuilder: (BuildContext context, int index) {
                var trans = transController.propsTransactionList[index];
                if (transController.propsTransactionList[index].id == null) {
                  return Container();
                }

                String startDate =
                    DateFormat('EEEE, MMM d, yyyy').format(trans.dateCreated!);

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
                    date: startDate,
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
                    amount: trans.disAmount.toString(),
                    date: startDate,
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
                    amount: trans.disAmount.toString(),
                    date: startDate,
                    trailingIcon: const Icon(
                      Icons.fiber_manual_record_outlined,
                      color: Colors.blue,
                    ),
                  );
                }
              },
            ),
          );
  }
}
