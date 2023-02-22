import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/model/property_model.dart';
import 'package:oga_bliss/widget/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/favourite_controller.dart';
import '../controller/property_controller.dart';
import '../screen/property_detailed_page.dart';
import '../util/currency_formatter.dart';

class PropertyWidget extends StatefulWidget {
  PropertyWidget({
    required this.props_image,
    required this.props_name,
    required this.props_type,
    required this.props_price,
    required this.isFav,
    required this.props_bedroom,
    required this.props_bathroom,
    required this.props_toilet,
    required this.props_image_counter,
    this.propertyModel,
    required this.route,
    this.adminStatus = false,
    this.adminTap = 'none',
  });

  String props_image;
  String props_name;
  String props_type;
  String props_price;
  bool isFav;
  String props_bedroom;
  String props_bathroom;
  String props_toilet;
  String props_image_counter;
  PropertyModel? propertyModel;
  String route;
  bool adminStatus;
  String adminTap;

  @override
  State<PropertyWidget> createState() => _PropertyWidgetState();
}

class _PropertyWidgetState extends State<PropertyWidget> {
  final propsController = PropertyController().getXID;
  final favController = FavouriteController().getXID;
  TextEditingController reasonController = TextEditingController();

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
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  bool isReportLoading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return (isLoading)
        ? const CardLoading(
            height: 250,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            margin: EdgeInsets.only(bottom: 10),
          )
        : Stack(
            children: [
              Card(
                elevation: 5,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => PropertyDetailPage(
                            propertyModel: widget.propertyModel,
                            route: widget.route,
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Image.network(
                            widget.props_image,
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/a.jpeg',
                                fit: BoxFit.fitWidth,
                              );
                            },
                            loadingBuilder:
                                (context, Widget child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                          (isReportLoading)
                              ? Positioned(
                                  top: 70,
                                  left: width * 0.45,
                                  child: Center(
                                    child: LoadingAnimationWidget.inkDrop(
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => PropertyDetailPage(
                                propertyModel: widget.propertyModel,
                                route: widget.route,
                              ),
                            );
                          },
                          child: Text(
                            widget.props_name,
                            style: const TextStyle(
                              fontFamily: 'Passion One',
                            ),
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                              color: (widget.props_type.toLowerCase() == "buy")
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              widget.props_type,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            CurrencyFormatter.getCurrencyFormatter(
                              amount: "${widget.props_price}",
                            ),
                            style: const TextStyle(
                              fontFamily: 'BlackOpsOne',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          //Rooms, toilet etc
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.bed_sharp,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${widget.props_bedroom} Bedroom',
                                    style: const TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.bathtub_rounded,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${widget.props_bathroom} Bathroom',
                                    style: const TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.event_seat_outlined,
                                    size: 14,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${widget.props_toilet} Toilet',
                                    style: const TextStyle(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      trailing: (widget.adminStatus)
                          ? const SizedBox(
                              width: 5,
                            )
                          : InkWell(
                              onTap: () async {
                                setState(() {
                                  widget.propertyModel!.favourite =
                                      !widget.isFav;
                                });

                                var status = await propsController.toggleLike(
                                  user_id,
                                  widget.propertyModel!.propsId,
                                  widget.propertyModel!,
                                  widget.route,
                                  user_status,
                                );

                                setState(() {
                                  widget.propertyModel!.favourite = status;
                                  if (widget.route == 'default') {
                                    int index = propsController.propertyList
                                        .indexOf(widget.propertyModel);
                                    propsController
                                        .propertyList[index].favourite = status;
                                  } else if (widget.route == 'search') {
                                    int index = propsController
                                        .searchPropertyList
                                        .indexOf(widget.propertyModel);
                                    propsController.searchPropertyList[index]
                                        .favourite = status;
                                  } else if (widget.route == 'fav') {
                                    int index = propsController.favPropertyList
                                        .indexOf(widget.propertyModel);

                                    propsController.favPropertyList[index]
                                        .favourite = status;

                                    if (status == false) {
                                      var propsId = propsController
                                          .favPropertyList[index].propsId;

                                      var newPropId = propsController
                                          .propertyList
                                          .indexWhere(
                                              ((p) => p.propsId == propsId));

                                      if (newPropId != -1) {
                                        propsController.propertyList[newPropId]
                                            .favourite = status;
                                      }

                                      //remove from favPropertyList
                                      propsController.favPropertyList
                                          .removeAt(index);
                                    }
                                  } else if (widget.route == 'dashboard') {
                                    int index = propsController.disPropertyList
                                        .indexOf(widget.propertyModel);
                                    propsController.disPropertyList[index]
                                        .favourite = status;

                                    if (status == false || status == true) {
                                      var propsId = propsController
                                          .disPropertyList[index].propsId;

                                      var newPropId = propsController
                                          .propertyList
                                          .indexWhere(
                                              ((p) => p.propsId == propsId));

                                      if (newPropId != -1) {
                                        propsController.propertyList[newPropId]
                                            .favourite = status;
                                      }

                                      //update myPropertyList
                                    }
                                  }
                                });
                              },
                              child: (widget.propertyModel?.favourite == true)
                                  ? const Icon(
                                      Icons.favorite_outlined,
                                      color: Colors.blue,
                                    )
                                  : const Icon(
                                      Icons.favorite_outlined,
                                      color: Colors.black38,
                                    ),
                            ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      stops: [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(.6),
                        Colors.black.withOpacity(.4)
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.camera_enhance_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        '/${widget.props_image_counter}',
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 0,
                child: (widget.adminStatus)
                    ? AdminPopupMenu(model: widget.propertyModel!)
                    : PopupMenuButton(
                        padding: const EdgeInsets.all(0),
                        color: Colors.black,
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          color: Colors.white,
                        ),
                        onSelected: (val) async {
                          setState(() {
                            isReportLoading = true;
                          });
                          bool status = await propsController.reportProperty(
                            propsId: widget.propertyModel!.propsId!,
                            userId: user_id!,
                            type: val,
                          );
                          if (status || !status) {
                            setState(() {
                              isReportLoading = false;
                            });
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'spam',
                              child: Text(
                                'Spam & Fraud',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'inappropriat_content',
                              child: Text(
                                'Inappropriate Content',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ];
                        },
                      ),
              ),
            ],
          );
  }

  Widget AdminPopupMenu({required PropertyModel model}) {
    if (model.propsLiveStatus == 'pending') {
      return PopupMenuButton(
        padding: const EdgeInsets.all(0),
        color: Colors.black,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.white,
        ),
        onSelected: (val) async {
          if (val == 'approve') {
            // //approve
            setState(() {
              isLoading = true;
            });
            bool status = await propsController.approveProperty(
              propsId: model.propsId!,
              userId: user_id!,
              agentId: model.propsAgentId!,
            );
            if (status) {
              setState(() {
                if (widget.adminTap == 'all') {
                  int index = propsController.allPropertyList.indexOf(model);
                  propsController.allPropertyList[index].propsLiveStatus =
                      'approved';
                  propsController.approvedPropertyList.add(model);

                  var newPropId = propsController.pendingPropertyList
                      .indexWhere(((p) => p.propsId == model.propsId));

                  if (newPropId != -1) {
                    propsController.pendingPropertyList.removeAt(newPropId);
                  }

                  var newPropId2 = propsController.rejectedPropertyList
                      .indexWhere(((p) => p.propsId == model.propsId));

                  if (newPropId2 != -1) {
                    propsController.rejectedPropertyList.removeAt(newPropId2);
                  }
                } else if (widget.adminTap == 'pending') {
                  int index = propsController.pendingPropertyList
                      .indexOf(widget.propertyModel);
                  propsController.pendingPropertyList[index].propsLiveStatus =
                      'approved';

                  propsController.approvedPropertyList.add(model);
                  propsController.pendingPropertyList.removeAt(index);
                  var newPropId = propsController.allPropertyList
                      .indexWhere(((p) => p.propsId == model.propsId));

                  if (newPropId != -1) {
                    propsController.allPropertyList[newPropId].propsLiveStatus =
                        'approved';
                  }
                } else if (widget.adminTap == 'rejected') {
                  int index = propsController.rejectedPropertyList
                      .indexOf(widget.propertyModel);
                  propsController.rejectedPropertyList[index].propsLiveStatus =
                      'approved';

                  propsController.approvedPropertyList.add(model);
                  propsController.rejectedPropertyList.removeAt(index);

                  var newPropId = propsController.allPropertyList
                      .indexWhere(((p) => p.propsId == model.propsId));

                  if (newPropId != -1) {
                    propsController.allPropertyList[newPropId].propsLiveStatus =
                        'approved';
                  }
                }

                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          } else if (val == 'reject') {
            Get.defaultDialog(
                title: 'Give Reason',
                middleText: 'Why are you Rejecting this property?',
                content: MyTextField(
                  myTextFormController: reasonController,
                  fieldName: 'Give Your Reason',
                ),
                textCancel: 'Cancel',
                onCancel: () {},
                textConfirm: 'Reject Now',
                onConfirm: () async {
                  setState(() {
                    isLoading = true;
                  });

                  bool status = await propsController.rejectProperty(
                    propsId: model.propsId!,
                    userId: user_id!,
                    agentId: model.propsAgentId!,
                    message: reasonController.text,
                  );

                  if (status) {
                    setState(() {
                      if (widget.adminTap == 'all') {
                        int index =
                            propsController.allPropertyList.indexOf(model);
                        propsController.allPropertyList[index].propsLiveStatus =
                            'rejected';
                        propsController.rejectedPropertyList.add(model);

                        //
                        var newPropId = propsController.approvedPropertyList
                            .indexWhere(((p) => p.propsId == model.propsId));

                        if (newPropId != -1) {
                          propsController.approvedPropertyList
                              .removeAt(newPropId);
                        }
                      } else if (widget.adminTap == 'pending') {
                        int index =
                            propsController.pendingPropertyList.indexOf(model);
                        propsController.pendingPropertyList[index]
                            .propsLiveStatus = 'rejected';
                        propsController.rejectedPropertyList.add(model);

                        var newPropId = propsController.allPropertyList
                            .indexWhere(((p) => p.propsId == model.propsId));

                        if (newPropId != -1) {
                          propsController.allPropertyList[newPropId]
                              .propsLiveStatus = 'rejected';
                        }

                        var newPropId3 = propsController.approvedPropertyList
                            .indexWhere(((p) => p.propsId == model.propsId));

                        if (newPropId3 != -1) {
                          propsController.approvedPropertyList
                              .removeAt(newPropId3);
                        }

                        propsController.pendingPropertyList.removeAt(index);
                      } else if (widget.adminTap == 'approved') {
                        int index =
                            propsController.approvedPropertyList.indexOf(model);
                        propsController.approvedPropertyList[index]
                            .propsLiveStatus = 'rejected';
                        propsController.rejectedPropertyList.add(model);

                        var newPropId = propsController.allPropertyList
                            .indexWhere(((p) => p.propsId == model.propsId));

                        if (newPropId != -1) {
                          propsController.allPropertyList[newPropId]
                              .propsLiveStatus = 'rejected';
                        }

                        var newPropId2 = propsController.pendingPropertyList
                            .indexWhere(((p) => p.propsId == model.propsId));

                        if (newPropId2 != -1) {
                          propsController.pendingPropertyList
                              .removeAt(newPropId2);
                        }

                        var newPropId3 = propsController.approvedPropertyList
                            .indexWhere(((p) => p.propsId == model.propsId));

                        if (newPropId3 != -1) {
                          propsController.approvedPropertyList
                              .removeAt(newPropId3);
                        }
                      }

                      isLoading = false;
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }

                  Navigator.of(context, rootNavigator: true).pop();
                });
            //reject
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: 'approve',
              child: Row(
                children: const [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Approve',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'reject',
              child: Row(
                children: const [
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Reject',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      );
    } else if (model.propsLiveStatus == 'rejected') {
      return PopupMenuButton(
        onSelected: (val) async {
          setState(() {
            isLoading = true;
          });
          bool status = await propsController.approveProperty(
            propsId: model.propsId!,
            userId: user_id!,
            agentId: model.propsAgentId!,
          );
          if (status) {
            setState(() {
              if (widget.adminTap == 'all') {
                int index = propsController.allPropertyList.indexOf(model);
                propsController.allPropertyList[index].propsLiveStatus =
                    'approved';
                propsController.approvedPropertyList.add(model);

                var newPropId = propsController.pendingPropertyList
                    .indexWhere(((p) => p.propsId == model.propsId));

                if (newPropId != -1) {
                  propsController.pendingPropertyList.removeAt(newPropId);
                }

                var newPropId2 = propsController.rejectedPropertyList
                    .indexWhere(((p) => p.propsId == model.propsId));

                if (newPropId2 != -1) {
                  propsController.rejectedPropertyList.removeAt(newPropId2);
                }
              } else if (widget.adminTap == 'pending') {
                int index = propsController.pendingPropertyList
                    .indexOf(widget.propertyModel);
                propsController.pendingPropertyList[index].propsLiveStatus =
                    'approved';

                propsController.approvedPropertyList.add(model);
                propsController.pendingPropertyList.removeAt(index);
                var newPropId = propsController.allPropertyList
                    .indexWhere(((p) => p.propsId == model.propsId));

                if (newPropId != -1) {
                  propsController.allPropertyList[newPropId].propsLiveStatus =
                      'approved';
                }
              } else if (widget.adminTap == 'rejected') {
                int index = propsController.rejectedPropertyList
                    .indexOf(widget.propertyModel);
                propsController.rejectedPropertyList[index].propsLiveStatus =
                    'approved';

                propsController.approvedPropertyList.add(model);
                propsController.rejectedPropertyList.removeAt(index);

                var newPropId = propsController.allPropertyList
                    .indexWhere(((p) => p.propsId == model.propsId));

                if (newPropId != -1) {
                  propsController.allPropertyList[newPropId].propsLiveStatus =
                      'approved';
                }
              }

              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
        },
        padding: const EdgeInsets.all(0),
        color: Colors.black,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: 'approve',
              child: Row(
                children: const [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Approve',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      );
    } else if (model.propsLiveStatus == 'approved') {
      return PopupMenuButton(
        onSelected: (val) {
          Get.defaultDialog(
              title: 'Give Reason',
              middleText: 'Why are you Rejecting this property?',
              content: MyTextField(
                myTextFormController: reasonController,
                fieldName: 'Give Your Reason',
              ),
              textCancel: 'Cancel',
              onCancel: () {},
              textConfirm: 'Reject Now',
              onConfirm: () async {
                setState(() {
                  isLoading = true;
                });

                bool status = await propsController.rejectProperty(
                  propsId: model.propsId!,
                  userId: user_id!,
                  agentId: model.propsAgentId!,
                  message: reasonController.text,
                );

                if (status) {
                  setState(() {
                    if (widget.adminTap == 'all') {
                      int index =
                          propsController.allPropertyList.indexOf(model);
                      propsController.allPropertyList[index].propsLiveStatus =
                          'rejected';
                      propsController.rejectedPropertyList.add(model);

                      var newPropId = propsController.pendingPropertyList
                          .indexWhere(((p) => p.propsId == model.propsId));

                      if (newPropId != -1) {
                        propsController.pendingPropertyList[newPropId]
                            .propsLiveStatus = 'rejected';
                      }
                    } else if (widget.adminTap == 'pending') {
                      int index =
                          propsController.pendingPropertyList.indexOf(model);
                      propsController.pendingPropertyList[index]
                          .propsLiveStatus = 'rejected';
                      propsController.rejectedPropertyList.add(model);
                      propsController.pendingPropertyList.removeAt(index);

                      var newPropId = propsController.allPropertyList
                          .indexWhere(((p) => p.propsId == model.propsId));

                      if (newPropId != -1) {
                        propsController.allPropertyList[newPropId]
                            .propsLiveStatus = 'rejected';
                      }

                      var newPropId3 = propsController.approvedPropertyList
                          .indexWhere(((p) => p.propsId == model.propsId));

                      if (newPropId3 != -1) {
                        propsController.approvedPropertyList
                            .removeAt(newPropId3);
                      }
                    } else if (widget.adminTap == 'approved') {
                      int index =
                          propsController.approvedPropertyList.indexOf(model);
                      propsController.approvedPropertyList[index]
                          .propsLiveStatus = 'rejected';
                      propsController.rejectedPropertyList.add(model);

                      propsController.approvedPropertyList.removeAt(index);

                      var newPropId = propsController.allPropertyList
                          .indexWhere(((p) => p.propsId == model.propsId));

                      if (newPropId != -1) {
                        propsController.allPropertyList[newPropId]
                            .propsLiveStatus = 'rejected';
                      }

                      var newPropId2 = propsController.pendingPropertyList
                          .indexWhere(((p) => p.propsId == model.propsId));

                      if (newPropId2 != -1) {
                        propsController.pendingPropertyList
                            .removeAt(newPropId2);
                      }
                    }

                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }

                Navigator.of(context, rootNavigator: true).pop();
              });
        },
        padding: const EdgeInsets.all(0),
        color: Colors.black,
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.white,
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              value: 'reject',
              child: Row(
                children: const [
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Reject',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      );
    } else {
      return Container();
    }
  }
}
