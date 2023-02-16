import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:oga_bliss/model/request_model.dart';
import 'package:oga_bliss/widget/small_btn.dart';

import '../controller/request_controller.dart';
import '../screen/view_user_profile.dart';

class requestWidget extends StatefulWidget {
  requestWidget({
    required this.user_id,
    required this.onTap,
    required this.user_status,
    required this.admin_status,
    required this.requestModel,
  });

  final String user_id;
  final VoidCallback onTap;

  final RequestModel requestModel;

  final String user_status;
  final bool admin_status;

  @override
  State<requestWidget> createState() => _requestWidgetState();
}

class _requestWidgetState extends State<requestWidget> {
  final requestController = RequestController().getXID;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: widget.onTap,
                    child: Image.network(
                      widget.requestModel.propsImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: widget.onTap,
                        child: Text(
                          widget.requestModel.propsName!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'RubikMonoOne-Regular',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Time: ${widget.requestModel.time}'),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Status: ${widget.requestModel.requestStatus}',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                showRequestAdminButton(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                userButton(),
                unreadButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget userButton() {
    if ((widget.user_status == 'agent' || widget.user_status == 'landlord') &&
        !widget.admin_status) {
      return smallBtn(
        btnName: 'View Requester',
        btnColor: Colors.black,
        loadingColor: Colors.white,
        isLoading: isLoading,
        onTap: () {
          Get.to(() => ViewUserProfile(
                id: widget.requestModel.disUserId!,
              ));
        },
      );
    } else if (widget.user_status == 'user' && !widget.admin_status) {
      return smallBtn(
        btnName: 'View Agent',
        btnColor: Colors.green,
        onTap: () {
          Get.to(() => ViewUserProfile(
                id: widget.requestModel.disUserId!,
              ));
        },
      );
    } else {
      return Expanded(
        child: Row(
          children: [
            smallBtn(
              btnName: 'User',
              btnColor: Colors.green,
              onTap: () {
                Get.to(() => ViewUserProfile(
                      id: widget.requestModel.disUserId!,
                    ));
              },
            ),
            smallBtn(
              btnName: 'Agent',
              btnColor: Colors.red,
              onTap: () {
                Get.to(() => ViewUserProfile(
                      id: widget.requestModel.disUserId!,
                    ));
              },
            ),
          ],
        ),
      );
    }
  }

  Widget unreadButton() {
    if (widget.user_id == widget.requestModel.disUserId &&
        widget.admin_status == false) {
      if (widget.requestModel.userReadStatus == 'unread') {
        return smallBtn(
          btnName: 'Mark as Read',
          btnColor: Colors.black,
          isLoading: isLoading,
          loadingColor: Colors.white,
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            bool status = await requestController.makeRequest(
              id: widget.requestModel.id.toString(),
              usersType: 'user',
            );

            if (status == true || status == false) {
              Future.delayed(const Duration(seconds: 1), () {
                setState(() {
                  isLoading = false;
                });
              });
            }

            Future.delayed(const Duration(seconds: 1), () {
              if (status) {
                //update the array
                if (mounted) {
                  setState(() {
                    int index = requestController.requestList
                        .indexOf(widget.requestModel);
                    requestController.requestList[index].userReadStatus =
                        "read";
                    requestController.requestList.removeAt(index);
                  });
                }
              }
            });
          },
        );
      }

      return Container();
    } else if (widget.user_id == widget.requestModel.agentId &&
        widget.admin_status == false) {
      return (widget.requestModel.agentReadStatus == 'unread')
          ? smallBtn(
              btnName: 'Mark as Read',
              btnColor: Colors.black,
              isLoading: isLoading,
              loadingColor: Colors.white,
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                bool status = await requestController.makeRequest(
                  id: widget.requestModel.id.toString(),
                  usersType: 'agent',
                );

                if (status == true || status == false) {
                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      isLoading = false;
                    });
                  });
                }

                Future.delayed(const Duration(seconds: 1), () {
                  if (status) {
                    //update the array
                    if (mounted) {
                      setState(() {
                        int index = requestController.requestList
                            .indexOf(widget.requestModel);
                        requestController.requestList[index].agentReadStatus =
                            "read";
                        requestController.requestList.removeAt(index);
                      });
                    }
                  }
                });
              },
            )
          : Container();
    } else {
      return smallBtn(
        btnName: 'Mark as Read',
        btnColor: Colors.black,
        isLoading: isLoading,
        loadingColor: Colors.white,
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          bool status = await requestController.makeRequest(
            id: widget.requestModel.id.toString(),
            usersType: 'admin',
          );

          if (status == true || status == false) {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                isLoading = false;
              });
            });
          }

          Future.delayed(const Duration(seconds: 1), () {
            if (status) {
              //update the array
              setState(() {
                if (mounted) {
                  int index = requestController.requestList
                      .indexOf(widget.requestModel);
                  var propsId = requestController.requestList[index].id;
                  requestController.requestList[index].adminReadStatus = "read";
                  requestController.requestList.removeAt(index);
                }
              });
            }
          });
        },
      );
    }
  }

  Widget showRequestAdminButton() {
    var model = widget.requestModel;
    if (widget.admin_status) {
      if (widget.requestModel.requestStatus == 'pending') {
        return PopupMenuButton(onSelected: (val) async {
          if (val == "start_request") {
            bool status = await requestController.setRequestStatus(
              id: model.id!,
              statusType: 'review',
              disUserId: model.disUserId!,
              agentId: model.agentId!,
              propsId: model.propsId!,
              user_id: widget.user_id,
            );
            //update the array
            if (status) {
              setState(() {
                int index =
                    requestController.requestList.indexOf(widget.requestModel);
                requestController.requestList[index].requestStatus = "review";
              });
            }
          } else if (val == "reject_request") {
            bool status = await requestController.setRequestStatus(
                id: model.id!,
                statusType: 'rejected',
                disUserId: model.disUserId!,
                agentId: model.agentId!,
                propsId: model.propsId!,
                user_id: widget.user_id);

            //update the array
            if (status) {
              setState(() {
                int index =
                    requestController.requestList.indexOf(widget.requestModel);
                requestController.requestList[index].requestStatus = "rejected";
                // requestController.requestList.removeAt(index);
              });
            }
          }
        }, itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: "start_request",
              child: Text('Start Request Review'),
            ),
            const PopupMenuItem(
              value: "reject_request",
              child: Text('Reject Request'),
            ),
          ];
        });
      } else if (widget.requestModel.requestStatus == 'review') {
        return PopupMenuButton(onSelected: (val) async {
          if (val == "confirm_review") {
            bool status = await requestController.setRequestStatus(
                id: model.id!,
                statusType: 'confirm',
                disUserId: model.disUserId!,
                agentId: model.agentId!,
                propsId: model.propsId!,
                user_id: widget.user_id);
            //update the array
            if (status) {
              setState(() {
                int index =
                    requestController.requestList.indexOf(widget.requestModel);
                requestController.requestList[index].requestStatus = "confirm";
              });
            }
          } else if (val == "reject_request") {
            bool status = await requestController.setRequestStatus(
                id: model.id!,
                statusType: 'rejected',
                disUserId: model.disUserId!,
                agentId: model.agentId!,
                propsId: model.propsId!,
                user_id: widget.user_id);

            //update the array
            if (status) {
              setState(() {
                int index =
                    requestController.requestList.indexOf(widget.requestModel);
                requestController.requestList[index].requestStatus = "rejected";
                // requestController.requestList.removeAt(index);
              });
            }
          }
        }, itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: "confirm_review",
              child: Text('Confirm Review'),
            ),
            const PopupMenuItem(
              value: "reject_request",
              child: Text('Reject Request'),
            ),
          ];
        });
      } else if (widget.requestModel.requestStatus == 'confirm') {
        if (widget.requestModel.openConnection == false) {
          return PopupMenuButton(onSelected: (val) async {
            if (val == "open_connection") {
              bool status = await requestController.setRequestStatus(
                id: model.id!,
                statusType: 'done',
                disUserId: model.disUserId!,
                agentId: model.agentId!,
                propsId: model.propsId!,
                user_id: widget.user_id,
              );
              //update the array
              if (status) {
                setState(() {
                  int index = requestController.requestList
                      .indexOf(widget.requestModel);
                  requestController.requestList[index].requestStatus = "done";
                });
              }
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                value: "open_connection",
                child: Text('Open Connection'),
              ),
            ];
          });
        }
      } else if (widget.requestModel.requestStatus == 'rejected') {
        return Container();
      }
    }
    return Container();
  }
}
