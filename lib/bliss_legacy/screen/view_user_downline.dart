import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/bliss_downline_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/bliss_downline_model.dart';
import 'package:oga_bliss/bliss_legacy/screen/downline_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/message_widget.dart';

class ViewUserDownline extends StatefulWidget {
  const ViewUserDownline({required this.downlineData});
  final User downlineData;

  @override
  State<ViewUserDownline> createState() => _ViewUserDownlineState();
}

class _ViewUserDownlineState extends State<ViewUserDownline> {
  final blissDownlineController = BlissDownlineController().getXID;

  late ScrollController _controller;

  String? user_id;
  String? user_name;
  String? user_status;
  bool? admin_status;
  bool? isUserLogin;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var userName1 = prefs.getString('user_name');
    var user_status1 = prefs.getString('user_status');
    var admin_status1 = prefs.getBool('admin_status');
    var isUserLogin1 = prefs.getBool('isUserLogin');

    if (mounted) {
      await blissDownlineController.getUsersDownline(
          1, widget.downlineData.agentId);
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
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      blissDownlineController.getUsersDownlineMore(
          current_page, widget.downlineData.agentId);

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
                      color: Colors.blue.shade900,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(35),
                      ),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 160.0, top: 20.0),
                      child: Text(
                        '${widget.downlineData.agentFullName} Downline',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 0, left: 0, right: 0, bottom: 80),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: blissDownlineController.viewUsersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = blissDownlineController.viewUsersList[index];
                    String startDate = DateFormat('EEEE, MMM d, yyyy')
                        .format(data.agentDateCreated!);
                    return Column(
                      children: [
                        messageWidget(
                          image_name: data.agentImageName!,
                          name: data.agentFullName!,
                          status: data.agentSex!,
                          onTap: () {
                            Get.off(
                              () => DownlineDetail(
                                data: data,
                              ),
                            );
                          },
                          time: startDate,
                          last_msg: '${data.countSub} Subscription Plan',
                          counter: '0',
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
