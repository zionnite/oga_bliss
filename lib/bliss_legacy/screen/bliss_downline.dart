import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/bliss_downline_controller.dart';
import 'package:oga_bliss/bliss_legacy/screen/downline_detail.dart';
import 'package:oga_bliss/widget/message_widget.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlissDownline extends StatefulWidget {
  const BlissDownline({Key? key}) : super(key: key);

  @override
  State<BlissDownline> createState() => _BlissDownlineState();
}

class _BlissDownlineState extends State<BlissDownline> {
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
      setState(() {
        user_id = userId1;
        user_name = userName1;
        user_status = user_status1;
        admin_status = admin_status1;
        isUserLogin = isUserLogin1;
      });

      await blissDownlineController.getUsers(1, user_id);
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

      blissDownlineController.getUsersMore(current_page, user_id);

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
            (Navigator.canPop(context))
                ? Padding(
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
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 160.0, top: 20.0),
                    child: Text(
                      'Your Downline & Generation',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => (blissDownlineController.isBUProcessing.value == 'null')
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.blue,
                        size: 30,
                      ),
                    )
                  : getData(),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => (blissDownlineController.usersList.isNotEmpty)
            ? Container()
            : InkWell(
                onTap: () {
                  setState(() {
                    blissDownlineController.isBUProcessing.value = 'null';
                    blissDownlineController.getUsers(1, user_id);
                    blissDownlineController.usersList.refresh();
                  });
                },
                child: Card(
                  elevation: 10,
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

  getData() {
    return Obx(
      () => (blissDownlineController.usersList.isEmpty)
          ? const ShowNotFound()
          : ListView.builder(
              padding:
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 80),
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: blissDownlineController.usersList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = blissDownlineController.usersList[index];
                String startDate = DateFormat('EEEE, MMM d, yyyy')
                    .format(data.agentDateCreated!);
                return Column(
                  children: [
                    messageWidget(
                      image_name: data.agentImageName!,
                      name: data.agentFullName!,
                      status: data.agentSex!,
                      onTap: () {
                        Get.to(
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
    );
  }
}
