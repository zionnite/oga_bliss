import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/controller/market_controller.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/widget/message_widget.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LinkActivity extends StatefulWidget {
  LinkActivity({required this.userId, required this.propsId});

  String userId;
  String propsId;

  @override
  State<LinkActivity> createState() => _LinkActivityState();
}

class _LinkActivityState extends State<LinkActivity> {
  final usersController = UsersController().getXID;
  final marketController = MarketController().getXID;

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

      //marketController.linkList.clear();
      await marketController.fetchLinkActivity(
          pageNum: 1, user_id: user_id!, props_id: widget.propsId);
    }
  }

  var current_page = 1;

  bool isLoading = false;
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

      marketController.fetchLinkActivityMore(
          pageNum: current_page, user_id: user_id!, props_id: widget.propsId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Link Activities'),
          Expanded(
            child: Obx(
              () => (marketController.isLinkProcessing == 'null')
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
    return (marketController.linkList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    marketController.isLinkProcessing.value = 'null';
                    marketController.fetchLinkActivity(
                        pageNum: 1,
                        user_id: user_id!,
                        props_id: widget.propsId);
                    marketController.linkList.refresh();
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
              itemCount: marketController.linkList.length,
              itemBuilder: (BuildContext context, int index) {
                var m_data = marketController.linkList[index];
                if (marketController.linkList[index].id == null) {
                  return Container();
                }

                return messageWidget(
                  image_name: m_data.userImageName!,
                  name: m_data.userFullName!,
                  status: m_data.userUserName!,
                  onTap: () {},
                  time: '',
                  last_msg: '',
                  counter: '0',
                );
              },
            ),
          );
  }
}
