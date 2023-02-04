import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/users_controller.dart';
import '../../../widget/usersWidget.dart';

class LandlordPage extends StatefulWidget {
  const LandlordPage({Key? key}) : super(key: key);

  @override
  State<LandlordPage> createState() => _LandlordPageState();
}

class _LandlordPageState extends State<LandlordPage> {
  final usersController = UsersController().getXID;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.only(bottom: 120),
        key: const PageStorageKey<String>('allLandlord'),
        physics: const ClampingScrollPhysics(),
        // itemExtent: 350,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: usersController.landLordList.length,
        itemBuilder: (BuildContext context, int index) {
          var users = usersController.landLordList[index];

          if (usersController.landLordList[index].agentId == null) {
            return Container();
          }
          return UsersWidget(
            avatarImg: users.agentImageName.toString(),
            avatarStatus: users.agentStatus.toString(),
            avatarId: users.agentId.toString(),
            avatarName: users.agentFullName.toString(),
            onMessageTap: () {},
            model: usersController.landLordList[index],
            userType: 'landlord',
          );
        },
      ),
    );
  }
}
