import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/widget/small_btn_icon.dart';

import '../controller/users_controller.dart';
import '../model/users_model.dart';
import '../screen/view_user_profile.dart';

class UsersWidget extends StatefulWidget {
  const UsersWidget({
    Key? key,
    required this.avatarImg,
    required this.avatarStatus,
    required this.avatarId,
    required this.avatarName,
    required this.onMessageTap,
    required this.model,
    required this.userType,
    // required this.con,
  }) : super(key: key);

  // final ConnectionModel con;

  final String avatarImg;
  final String avatarStatus;
  final String avatarId;
  final String avatarName;
  final VoidCallback onMessageTap;
  final UsersModel model;
  final String userType;

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  final usersController = UsersController().getXID;

  bool isLoading = false;
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    var model = widget.model;
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => ViewUserProfile(id: widget.avatarId));
                  },
                  child: CircleAvatar(
                    radius: 40,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                        widget.avatarImg,
                      ),
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
                          widget.avatarName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Passion One',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.avatarStatus),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                smallBtnIcon(
                  btnName: (model.agentLoginStatus == 'ban')
                      ? 'UnBan User'
                      : 'Ban User',
                  btnColor: Colors.blue.shade900,
                  isLoading: isLoading,
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Ban User',
                      middleText:
                          'Are you sure you want to ban ${widget.avatarName}',
                      textConfirm: 'Yes',
                      onConfirm: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        setState(() {
                          isLoading = true;
                        });
                        String status = await usersController.toggleBan(
                            userId: widget.avatarId);

                        if (status == 'ban') {
                          setState(() {
                            if (widget.userType == 'user') {
                              int index = usersController.usersList
                                  .indexOf(widget.model);
                              usersController
                                  .usersList[index].agentLoginStatus = 'ban';
                            } else if (widget.userType == 'landlord') {
                              int index = usersController.landLordList
                                  .indexOf(widget.model);
                              usersController
                                  .landLordList[index].agentLoginStatus = 'ban';
                            }

                            isLoading = false;
                          });
                        } else if (status == 'unban') {
                          setState(() {
                            if (widget.userType == 'user') {
                              int index = usersController.usersList
                                  .indexOf(widget.model);
                              usersController
                                  .usersList[index].agentLoginStatus = 'normal';
                            } else if (widget.userType == 'landlord') {
                              int index = usersController.landLordList
                                  .indexOf(widget.model);
                              usersController.landLordList[index]
                                  .agentLoginStatus = 'normal';
                            }
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      textCancel: 'No',
                      onCancel: () {},
                    );
                  },
                  icon: (model.agentLoginStatus == 'ban')
                      ? Icons.lock_open
                      : Icons.lock,
                  icon_color: Colors.white,
                  icon_size: 15,
                  font_size: 13,
                ),
                smallBtnIcon(
                  btnName: 'Delete User',
                  btnColor: Colors.blue.shade900,
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Delete User',
                      middleText:
                          'Are you sure you want to Delete ${widget.avatarName}',
                      textConfirm: 'Yes',
                      onConfirm: () async {
                        Navigator.of(context, rootNavigator: true).pop();
                        setState(() {
                          isDeleting = true;
                        });
                        bool status = await usersController.deleteUser(
                            userId: widget.avatarId);

                        if (status) {
                          setState(() {
                            if (widget.userType == 'user') {
                              int index = usersController.usersList
                                  .indexOf(widget.model);
                              usersController.usersList.removeAt(index);
                            } else if (widget.userType == 'landlord') {
                              int index = usersController.landLordList
                                  .indexOf(widget.model);
                              usersController.landLordList.removeAt(index);
                            }

                            isDeleting = true;
                          });
                        } else {
                          setState(() {
                            isDeleting = false;
                          });
                        }
                      },
                      textCancel: 'No',
                      onCancel: () {},
                    );
                  },
                  icon: Icons.delete_forever,
                  icon_color: Colors.white,
                  icon_size: 15,
                  font_size: 13,
                  isLoading: isDeleting,
                ),
                smallBtnIcon(
                  btnName: 'Send Email',
                  btnColor: Colors.blue.shade900,
                  onTap: widget.onMessageTap,
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
    );
  }
}
