import 'package:flutter/material.dart';

import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/request_widget.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Request'),
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
                  requestWidget(
                    name: 'A User Requested for site Inspection',
                    time: '3mins Ago',
                    status: 'In-View',
                    image_name:
                        'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                    onTap: () {
                      print('image just checking');
                    },
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
