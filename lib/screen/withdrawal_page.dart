import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/controller/withdrawal_controller.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/util/currency_formatter.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/property_btn_icon.dart';
import 'package:oga_bliss/widget/request_withdrawal.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:oga_bliss/widget/small_btn_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({Key? key}) : super(key: key);

  @override
  State<WithdrawalPage> createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
  final usersController = UsersController().getXID;
  final withdrawalController = WithdrawalController().getXID;

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

      await withdrawalController.fetchWithdrawal(1, user_id, admin_status);
    }
  }

  var current_page = 1;

  bool isApproveLoading = false;
  bool isRejectLoading = false;
  int selectedItem = -1;

  @override
  void initState() {
    initUserDetail();
    super.initState();

    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        current_page++;
      });

      withdrawalController.fetchWithdrawalMore(
          current_page, user_id, admin_status);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Withdrawal List'),
          (admin_status == false)
              ? PropertyBtnIcon(
                  onTap: () {
                    Get.to(() => const RequestWithdrawal());
                  },
                  title: 'Make Request',
                  bgColor: Colors.blue,
                  icon: Icons.wallet_sharp,
                  icon_color: Colors.white,
                  icon_size: 20,
                  elevation: 2,
                )
              : Container(),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Obx(
              () => (withdrawalController.isWithdrawalProcessing == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 20,
                      ),
                    )
                  : detail(),
            ),
          ),
        ],
      ),
    );
  }

  Widget detail() {
    return (withdrawalController.withdrawalList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    withdrawalController.isWithdrawalProcessing.value = 'null';
                    withdrawalController.fetchWithdrawal(
                        1, user_id, admin_status);
                    withdrawalController.withdrawalList.refresh();
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
              // key: UniqueKey(),
              controller: _controller,
              padding: const EdgeInsets.only(bottom: 120),
              key: const PageStorageKey<String>('allTransaction'),
              physics: const ClampingScrollPhysics(),
              // itemExtent: 350,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: withdrawalController.withdrawalList.length,
              itemBuilder: (BuildContext context, int index) {
                var w_data = withdrawalController.withdrawalList[index];
                if (withdrawalController.withdrawalList[index].id == null) {
                  return Container();
                }

                String startDate =
                    DateFormat('EEEE, MMM d, yyyy').format(w_data.dateCreated!);

                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/a.jpeg',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          CurrencyFormatter.getCurrencyFormatter(
                              amount: '${w_data.amount}'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                '${startDate}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            (w_data.disStatus == 'pending')
                                ? const Text(
                                    'Pending',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  )
                                : (w_data.disStatus == 'approved')
                                    ? const Text(
                                        'Approved',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      )
                                    : const Text(
                                        'Rejected',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                          ],
                        ),
                        trailing: (w_data.paidStatus == 'unpaid')
                            ? const Icon(
                                Icons.check_circle_outline,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                      ),
                      (admin_status == true && w_data.disStatus == 'pending')
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0),
                              child: Row(
                                children: [
                                  smallBtnIcon(
                                    btnName: 'Approve',
                                    btnColor: Colors.blue.shade900,
                                    onTap: () async {
                                      setState(() {
                                        isApproveLoading = true;
                                        selectedItem = index;
                                      });
                                      String status = await withdrawalController
                                          .approveWithdrawalRequest(
                                              disUserId: w_data.disUserId!,
                                              id: w_data.id!);
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        setState(() {
                                          isApproveLoading = false;
                                          selectedItem = -1;
                                        });
                                      });

                                      if (status == 'true') {
                                        setState(() {
                                          w_data.disStatus = 'approved';
                                        });
                                        showSnackBar(
                                            title: 'Action Status',
                                            msg: 'Request Approved',
                                            backgroundColor: Colors.blue,
                                            duration:
                                                const Duration(seconds: 1));
                                      } else if (status == 'false') {
                                        showSnackBar(
                                            title: 'Action Status',
                                            msg:
                                                'Database Busy, Could not perform operation, Pls Try Again Later!',
                                            backgroundColor: Colors.blue,
                                            duration:
                                                const Duration(seconds: 10));
                                      } else {
                                        showSnackBar(
                                            title: 'Action Status',
                                            msg:
                                                'The System cannot approved this, because requested amount its greaterthan Payable Balance, please REJECT THIS REQUEST',
                                            backgroundColor: Colors.blue,
                                            duration:
                                                const Duration(seconds: 10));
                                      }
                                    },
                                    icon: Icons.check,
                                    icon_color: Colors.white,
                                    isLoading: isApproveLoading,
                                    item: index,
                                    selecteditem: selectedItem,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  smallBtnIcon(
                                    btnName: 'Reject',
                                    btnColor: Colors.blue.shade900,
                                    onTap: () async {
                                      setState(() {
                                        isRejectLoading = true;
                                        selectedItem = index;
                                      });
                                      String status = await withdrawalController
                                          .rejectWithdrawalRequest(
                                              disUserId: w_data.disUserId!,
                                              id: w_data.id!);
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        setState(() {
                                          isRejectLoading = false;
                                          selectedItem = -1;
                                        });
                                      });

                                      if (status == 'true') {
                                        setState(() {
                                          w_data.disStatus = 'rejected';
                                        });
                                        showSnackBar(
                                            title: 'Action Status',
                                            msg: 'Request Rejected',
                                            backgroundColor: Colors.blue,
                                            duration:
                                                const Duration(seconds: 1));
                                      } else if (status == 'false') {
                                        showSnackBar(
                                            title: 'Action Status',
                                            msg:
                                                'Database Busy, Could not perform operation, Pls Try Again Later!',
                                            backgroundColor: Colors.blue,
                                            duration:
                                                const Duration(seconds: 10));
                                      }
                                    },
                                    icon: Icons.cancel,
                                    icon_color: Colors.white,
                                    isLoading: isRejectLoading,
                                    item: index,
                                    selecteditem: selectedItem,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
