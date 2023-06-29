import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/widget/message_widget.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferalPage extends StatefulWidget {
  const ReferalPage({Key? key}) : super(key: key);

  @override
  State<ReferalPage> createState() => _ReferalPageState();
}

class _ReferalPageState extends State<ReferalPage> {
  final usersController = UsersController().getXID;
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

      await usersController.getReferal(1, user_id);
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

      usersController.getReferalMore(current_page, user_id);

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
          const PropertyAppBar(title: 'My Referral'),
          Obx(
            () => (usersController.isReferalFetchProcessing == 'null')
                ? Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue,
                      size: 20,
                    ),
                  )
                : detail(),
          ),
        ],
      ),
    );
  }

  Widget detail() {
    return (usersController.referalList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    usersController.isReferalFetchProcessing.value = 'null';
                    usersController.getReferal(1, user_id);
                    usersController.referalList.refresh();
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
            child: Obx(
              () => ListView.builder(
                controller: _controller,
                padding: const EdgeInsets.only(bottom: 120),
                key: const PageStorageKey<String>('allChatHead'),
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: usersController.referalList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var user = usersController.referalList[index];
                  if (usersController.referalList[index].agentId == null) {
                    return Container();
                  }

                  return messageWidget(
                    image_name: user.agentImageName!,
                    name: user.agentFullName!,
                    status: user.agentUserName!,
                    onTap: () {},
                    time: '',
                    last_msg: '',
                    counter: '0',
                  );
                },
              ),
            ),
          );
  }
}
