import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/screen/view_propert_detailed_dash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/request_controller.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/request_widget.dart';

final pageBucket = PageStorageBucket();

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final requestController = RequestController().getXID;
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
      await requestController.fetchRequest(1, user_id, admin_status);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = requestController.isDataProcessing.value;
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

    Future.delayed(const Duration(seconds: 1), () {
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

      requestController.fetchRequestMore(current_page, user_id, admin_status);

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
          const PropertyAppBar(title: 'Request'),
          Expanded(
            child: (widgetLoading)
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue,
                      size: 20,
                    ),
                  )
                : (requestController.requestList.isEmpty)
                    ? showNotFound()
                    : PageStorage(
                        bucket: pageBucket,
                        child: SingleChildScrollView(
                          controller: _controller,
                          key: const PageStorageKey<String>('allRequest'),
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
                                  padding: const EdgeInsets.only(bottom: 120),
                                  key: const PageStorageKey<String>(
                                      'allRequest'),
                                  physics: const ClampingScrollPhysics(),
                                  // itemExtent: 350,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount:
                                      requestController.requestList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var req =
                                        requestController.requestList[index];
                                    if (index ==
                                            requestController
                                                    .requestList.length +
                                                1 &&
                                        isLoading == true) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (requestController
                                            .requestList[index].id ==
                                        null) {
                                      requestController
                                          .isMoreDataAvailable.value = false;
                                      return Container();
                                    }
                                    return requestWidget(
                                      user_id: user_id!,
                                      onTap: () {
                                        Get.to(
                                            () => ViewPropertyDetailedDashboard(
                                                  propsId: req.propsId!,
                                                  route: 'dashboard',
                                                ));
                                      },
                                      user_status: user_status!,
                                      admin_status: admin_status!,
                                      requestModel: req,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          )
        ],
      ),
    );
  }
}
