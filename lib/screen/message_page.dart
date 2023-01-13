import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  messageWidget(
                    image_name:
                        'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                    name: 'Nosakhare Atekha Endurance zionnite',
                    status: 'Landlord',
                    onTap: () {
                      Get.to(() => const MessageAlonePage());
                    },
                    time: '3hrs ago',
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
