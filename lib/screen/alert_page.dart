import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/alert_controller.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final alertController = AlertController().getXID;
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

      await alertController.fetchAlert(1, user_id);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() async {
    var loading = alertController.isAlertProcessing.value;
    if (loading == 'yes') {
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

      alertController.fetchAlertMore(current_page, user_id);

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
      appBar: AppBar(
        title: const Text(
          'Alert',
        ),
        backgroundColor: backgroundColorPrimary,
      ),
      body: Obx(
        () => (alertController.isAlertProcessing == 'null')
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.blue,
                  size: 30,
                ),
              )
            : details(),
      ),
    );
  }

  Widget details() {
    return (alertController.alertList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    alertController.isAlertProcessing.value = 'null';
                    alertController.fetchAlert(1, user_id);
                    alertController.alertList.refresh();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
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
        : SlidableAutoCloseBehavior(
            closeWhenOpened: true,
            child: Obx(
              () => ListView.builder(
                controller: _controller,
                padding: const EdgeInsets.only(
                  bottom: 120,
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                ),
                key: const PageStorageKey<String>('allAlert'),
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: alertController.alertList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (val) async {
                            bool status = await alertController.deleteAlert(
                                id: alertController.alertList[index].id!);
                            if (status) {
                              setState(() {
                                alertController.alertList.removeAt(index);
                              });
                            }
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.warning_sharp,
                            color: Colors.red,
                          ),
                          title: Text(
                            '${alertController.alertList[index].description!}',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
