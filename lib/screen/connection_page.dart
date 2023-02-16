import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/screen/view_user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/connection_controller.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/small_btn_icon.dart';
import 'message_alone_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final conController = ConnectionController().getXID;
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
      await conController.fetchConnection(1, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = conController.isDataProcessing.value;
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

      conController.fetchConnectionMore(current_page, user_id);

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
          const PropertyAppBar(title: 'Connection'),
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
                  (widgetLoading)
                      ? Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.blue,
                            size: 20,
                          ),
                        )
                      : (conController.connectionList.isEmpty)
                          ? showNotFound()
                          : Obx(
                              () => ListView.builder(
                                controller: _controller,
                                padding: const EdgeInsets.only(bottom: 120),
                                key: const PageStorageKey<String>(
                                    'allConnection'),
                                physics: const ClampingScrollPhysics(),
                                // itemExtent: 350,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: conController.connectionList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var con = conController.connectionList[index];

                                  if (conController.connectionList[index].id ==
                                      null) {
                                    return Container();
                                  }

                                  if (user_status == 'agent' ||
                                      user_status == 'landlord') {
                                    return connectionWidget(
                                      avatarImg: con.getUserImage.toString(),
                                      avatarStatus:
                                          con.getUserStatus.toString(),
                                      avatarId: con.disUserId.toString(),
                                      avatarName:
                                          con.getUserFullName.toString(),
                                      onMessageTap: () {
                                        Get.to(
                                          () => MessageAlonePage(
                                            sender: con.disUserId.toString(),
                                            receiver: con.agentId.toString(),
                                            propsId: con.propsId.toString(),
                                            image_name:
                                                con.getUserImage.toString(),
                                            status:
                                                con.getUserStatus.toString(),
                                            name:
                                                con.getUserFullName.toString(),
                                          ),
                                        );
                                      },
                                    );
                                  } else if (user_status == 'user') {
                                    return connectionWidget(
                                      avatarImg: con.getAgentImage.toString(),
                                      avatarStatus:
                                          con.getAgentStatus.toString(),
                                      avatarId: con.agentId.toString(),
                                      avatarName:
                                          con.getAgentFullName.toString(),
                                      onMessageTap: () {
                                        Get.to(
                                          () => MessageAlonePage(
                                            sender: con.agentId.toString(),
                                            receiver: con.disUserId.toString(),
                                            propsId: con.propsId.toString(),
                                            image_name:
                                                con.getAgentImage.toString(),
                                            status:
                                                con.getAgentStatus.toString(),
                                            name:
                                                con.getAgentFullName.toString(),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return Container();
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

class connectionWidget extends StatelessWidget {
  const connectionWidget({
    Key? key,
    required this.avatarImg,
    required this.avatarStatus,
    required this.avatarId,
    required this.avatarName,
    required this.onMessageTap,
    // required this.con,
  }) : super(key: key);

  // final ConnectionModel con;

  final String avatarImg;
  final String avatarStatus;
  final String avatarId;
  final String avatarName;
  final VoidCallback onMessageTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
          top: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: NetworkImage(
                  avatarImg,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      avatarName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Passion One',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(avatarStatus),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        smallBtnIcon(
                          btnName: 'View User',
                          btnColor: Colors.blue,
                          onTap: () {
                            Get.to(() => ViewUserProfile(id: avatarId));
                          },
                          icon: Icons.person,
                          icon_color: Colors.white,
                          icon_size: 15,
                          font_size: 13,
                        ),
                        smallBtnIcon(
                          btnName: 'Message',
                          btnColor: Colors.green,
                          onTap: onMessageTap,
                          icon: Icons.email,
                          icon_color: Colors.white,
                          icon_size: 15,
                          font_size: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
