import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/widget/property_app_bar.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/chat_head_controller.dart';
import '../widget/message_widget.dart';
import 'message_alone_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final chController = ChatHeadController().getXID;
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

      await chController.fetchChatHead(1, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = chController.isChatHeadProcessing;
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

      chController.fetchChatHeadMore(current_page, user_id);

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
          const PropertyAppBar(title: 'Conversation'),
          Obx(
            () => (chController.isChatHeadProcessing == 'null')
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
    return (chController.chatHeadList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    chController.isChatHeadProcessing.value = 'null';
                    chController.fetchChatHead(1, user_id);
                    chController.chatHeadList.refresh();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
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
                itemCount: chController.chatHeadList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var chat = chController.chatHeadList[index];
                  if (chController.chatHeadList[index].id == null) {
                    return Container();
                  }
                  if (user_id != chat.disUserId) {
                    return messageWidget(
                      image_name: chat.disUserImageName!,
                      name: chat.disUserFullName!,
                      status: chat.disUserUserStatus!,
                      onTap: () {
                        Get.to(
                          () => MessageAlonePage(
                            sender: chat.disUserId!,
                            receiver: chat.disMyId!,
                            propsId: chat.propsId!,
                            image_name: chat.disUserImageName!,
                            status: chat.disUserUserStatus!,
                            name: chat.disUserFullName!,
                          ),
                        );
                      },
                      time: chat.lastTimeMsg.toString(),
                      last_msg: chat.lastMsg.toString(),
                      counter: chat.countUnreadMsg.toString(),
                    );
                  }
                  return Container();
                },
              ),
            ),
          );
  }
}
