import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/dashboard_controller.dart';
import 'package:oga_bliss/model/dashboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/property_app_bar.dart';
import '../widget/property_card.dart';
import '../widget/show_not_found.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final dashController = DashboardController().getXID;

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

      await dashController.getCounters(user_id, admin_status, user_status);
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Dashboard'),
          Obx(
            () => (dashController.isDashboardProcessing == 'null')
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue,
                      size: 30,
                    ),
                  )
                : details(),
          ),
        ],
      ),
    );
  }

  Widget details() {
    return (dashController.counterList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    dashController.isDashboardProcessing.value = 'null';
                    dashController.getCounters(
                        user_id, admin_status, user_status);
                    dashController.counterList.refresh();
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
        : Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.all(0),
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dashController.counterList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var dash = dashController.counterList[index];
                    return Column(
                      children: [
                        adminWidget(model: dash),
                        agentWidget(model: dash),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
  }

  Widget adminWidget({required DashboardModel model}) {
    return (user_status == 'admin' || user_status == 'super_admin')
        ? Column(
            children: [
              propertyCard(
                bgColor1: Colors.red,
                bgColor2: Colors.orange,
                title: 'Total Earning',
                isNaira: true,
                value: '${model.totalEarning}',
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade400,
                title: 'Total Transaction',
                isNaira: false,
                value: '${model.totalTransaction}',
                icon: const Icon(
                  Icons.cases_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.black54,
                bgColor2: Colors.black,
                title: 'Total Property',
                value: '${model.totalProperty}',
                isNaira: false,
                icon: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.orange.shade400,
                title: 'Payable Balance',
                value: '${model.payableBalance}',
                isNaira: true,
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.purple,
                bgColor2: Colors.blue.shade400,
                title: 'Total Alert',
                value: '${model.countAlert}',
                isNaira: false,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.green,
                bgColor2: Colors.green.shade400,
                title: 'Total Request',
                value: '${model.totalRequest}',
                isNaira: false,
                icon: const Icon(
                  Icons.trending_up_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.orange.shade400,
                title: 'Overall Amount Transacted',
                value: '${model.totalAmountTransacted}',
                isNaira: true,
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.orange.shade400,
                title: 'Referral Balance',
                value: '${model.referalBalance}',
                isNaira: true,
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.orange.shade400,
                title: 'Total Amount Subscribed',
                value: '${model.totalAmountSubscribed}',
                isNaira: true,
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.orange.shade400,
                title: 'Count All User',
                value: '${model.allUsers}',
                isNaira: false,
                icon: const Icon(
                  Icons.people_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          )
        : Container();
  }

  Widget agentWidget({required DashboardModel model}) {
    return (admin_status != true)
        ? Column(
            children: [
              propertyCard(
                bgColor1: Colors.red,
                bgColor2: Colors.orange,
                title: 'Total Earning',
                isNaira: true,
                value: '${model.totalEarning}',
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.blue,
                bgColor2: Colors.blue.shade400,
                title: 'Total Transaction',
                isNaira: false,
                value: '${model.totalTransaction}',
                icon: const Icon(
                  Icons.cases_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.black54,
                bgColor2: Colors.black,
                title: 'Total Property',
                value: '${model.totalProperty}',
                isNaira: false,
                icon: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.red,
                title: 'Payable Balance',
                value: '${model.payableBalance}',
                isNaira: true,
                icon: const Icon(
                  Icons.wallet,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.green,
                bgColor2: Colors.green.shade400,
                title: 'Total Alert',
                value: '${model.countAlert}',
                isNaira: false,
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.orange,
                bgColor2: Colors.orange.shade400,
                title: 'Count Referral',
                value: '${model.countReferaal}',
                isNaira: false,
                icon: const Icon(
                  Icons.groups_2_sharp,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.black54,
                bgColor2: Colors.black,
                title: 'Count Downline',
                value: '${model.countDownlines}',
                isNaira: false,
                icon: const Icon(
                  Icons.lan_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          )
        : Container();
  }
}
