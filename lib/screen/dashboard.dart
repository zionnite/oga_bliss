import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/controller/dashboard_controller.dart';
import 'package:oga_bliss/model/dashboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/property_card.dart';

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
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => ListView.builder(
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
                        userWidget(model: dash),
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
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
                title: 'Insurance Balance',
                value: '${model.insuranceEarning}',
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
                bgColor1: Colors.green,
                bgColor2: Colors.green.shade400,
                title: 'Total Transaction',
                value: '${model.totalTransaction}',
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
                title: 'Total Connection',
                value: '${model.totalConnection}',
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
    return (user_status == 'agent' || user_status == 'landlord')
        ? Column(
            children: [
              propertyCard(
                bgColor1: Colors.red,
                bgColor2: Colors.orange,
                title: 'Total Earning',
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
                title: 'Wallet Balance',
                value: '${model.walletBalance}',
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
                bgColor1: Colors.green,
                bgColor2: Colors.green.shade400,
                title: 'Total Transaction',
                value: '${model.totalTransaction}',
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
                title: 'Total Connection',
                value: '${model.totalConnection}',
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

  Widget userWidget({required DashboardModel model}) {
    return (user_status == 'user')
        ? Column(
            children: [
              propertyCard(
                bgColor1: Colors.red,
                bgColor2: Colors.orange,
                title: 'Total Earning',
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
                title: 'Wallet Balance',
                value: '${model.walletBalance}',
                icon: const Icon(
                  Icons.cases_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              propertyCard(
                bgColor1: Colors.green,
                bgColor2: Colors.green.shade400,
                title: 'Total Transaction',
                value: '${model.totalTransaction}',
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
                title: 'Total Connection',
                value: '${model.totalConnection}',
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
}
