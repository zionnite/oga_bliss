import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_head_controller.dart';
import '../widget/message_widget.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import 'message_alone_page.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final chController = ChatHeadController().getXID;
  late ScrollController _controller;

  String user_id = '1';
  String user_status = 'user';
  bool admin_status = true;

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = chController.isDataProcessing.value;
    if (loading) {
      setState(() {
        widgetLoading = false;
      });
    }
  }

  @override
  void initState() {
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

      chController.fetchChatHeadMore(current_page);

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
                  Obx(
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
                                ),
                              );
                            },
                            time: '',
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
