import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/bliss_transaction_controller.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:oga_bliss/widget/transaction_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayoutTransactionPage extends StatefulWidget {
  const PayoutTransactionPage({Key? key}) : super(key: key);

  @override
  State<PayoutTransactionPage> createState() => _PayoutTransactionPageState();
}

class _PayoutTransactionPageState extends State<PayoutTransactionPage> {
  final blissTransactionController = BlissTransactionController().getXID;

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

      await blissTransactionController.fetchTransaction(
          1, user_id, admin_status);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = blissTransactionController.isBlissTransactionProcessing;
    if (loading == 'yes' || loading == 'no') {
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

      blissTransactionController.fetchTransactionMore(
          current_page, user_id, admin_status);

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
          const PropertyAppBar(title: 'MLM Transactions'),
          Expanded(
            child: Obx(
              () => (blissTransactionController.isBlissTransactionProcessing ==
                      'null')
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
    return (blissTransactionController.transactionList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    blissTransactionController
                        .isBlissTransactionProcessing.value = 'null';
                    blissTransactionController.fetchTransaction(
                        1, user_id, admin_status);
                    blissTransactionController.transactionList.refresh();
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
              itemCount: blissTransactionController.transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                var trans = blissTransactionController.transactionList[index];
                if (blissTransactionController.transactionList[index].id ==
                    null) {
                  return Container();
                }

                // String startDate = DateFormat('EEEE, MMM d, yyyy')
                //     .format(DateTime.parse(trans.dateCreated!));

                return transactionWidget(
                  leadingIcon: (trans.transType == 'deposit')
                      ? const Icon(
                          Icons.trending_up,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.trending_down,
                          color: Colors.red,
                        ),
                  amount: trans.disAmount.toString(),
                  date: trans.dateCreated!,
                );
              },
            ),
          );
  }
}
