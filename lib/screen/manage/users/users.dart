import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/screen/manage/users/send_email.dart';

import '../../../widget/usersWidget.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersController = UsersController().getXID;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        key: const PageStorageKey<String>('allConnection'),
        physics: const ClampingScrollPhysics(),
        // itemExtent: 350,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: usersController.usersList.length,
        itemBuilder: (BuildContext context, int index) {
          var users = usersController.usersList[index];

          if (usersController.usersList[index].agentId == null) {
            return Container();
          }
          return UsersWidget(
            avatarImg: users.agentImageName.toString(),
            avatarStatus: users.agentStatus.toString(),
            avatarId: users.agentId.toString(),
            avatarName: users.agentFullName.toString(),
            onMessageTap: () {
              Get.to(
                () => SendEmail(
                  dis_user_id: users.agentId!,
                  full_name: users.agentFullName!,
                  email: users.agentEmail!,
                ),
              );
            },
            model: usersController.usersList[index],
            userType: 'user',
          );
        },
      ),
    );
  }
}
