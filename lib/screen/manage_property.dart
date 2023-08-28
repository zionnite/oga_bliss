import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/property_controller.dart';
import 'manage/property/manage_all_property.dart';
import 'manage/property/manage_approved_property.dart';
import 'manage/property/manage_pending_property.dart';
import 'manage/property/manage_rejected_property.dart';

class ManageProperty extends StatefulWidget {
  const ManageProperty({Key? key}) : super(key: key);

  @override
  State<ManageProperty> createState() => _ManagePropertyState();
}

class _ManagePropertyState extends State<ManageProperty> {
  final propsController = PropertyController().getXID;
  late ScrollController _controller;
  late ScrollController _controller_2;
  late ScrollController _controller_3;
  late ScrollController _controller_4;

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
      await propsController.manageProduct(user_id, 'all');
      await propsController.manageProduct(user_id, 'pending');
      await propsController.manageProduct(user_id, 'approved');
      await propsController.manageProduct(user_id, 'rejected');
    }
  }

  var current_page = 1;
  var current_page_pending = 1;
  var current_page_approved = 1;
  var current_page_rejected = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  @override
  void initState() {
    initUserDetail();
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
    _controller_2 = ScrollController()..addListener(_scrollListener_2);
    _controller_3 = ScrollController()..addListener(_scrollListener_3);
    _controller_4 = ScrollController()..addListener(_scrollListener_4);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      propsController.manageProductMore(current_page, user_id, 'all');

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _scrollListener_2() {
    if (_controller_2.position.pixels ==
        _controller_2.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page_pending++;
      });

      propsController.manageProductMore(
        current_page_pending,
        user_id,
        'pending',
      );

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _scrollListener_3() {
    if (_controller_3.position.pixels ==
        _controller_3.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page_approved++;
      });

      propsController.manageProductMore(
        current_page_approved,
        user_id,
        'approved',
      );

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _scrollListener_4() {
    if (_controller_4.position.pixels ==
        _controller_4.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page_rejected++;
      });

      propsController.manageProductMore(
        current_page_rejected,
        user_id,
        'rejected',
      );

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  getAllProperty() {
    return (propsController.allPropertyList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isAllProductProcessing.value = 'null';
                    propsController.manageProduct(user_id, 'all');
                    propsController.allPropertyList.refresh();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
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
        : const ManageAllProperty();
  }

  getPendingProperty() {
    return (propsController.pendingPropertyList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isPendingProductProcessing.value = 'null';
                    propsController.manageProduct(user_id, 'pending');
                    propsController.pendingPropertyList.refresh();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
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
        : const ManageAllPendingProperty();
  }

  getApprovedProperty() {
    return (propsController.approvedPropertyList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isApprovedProductProcessing.value = 'null';
                    propsController.manageProduct(user_id, 'approved');
                    propsController.approvedPropertyList.refresh();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
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
        : const ManageAllApprovedProperty();
  }

  getRejectedProperty() {
    return (propsController.rejectedPropertyList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    propsController.isRejectedProductProcessing.value = 'null';
                    propsController.manageProduct(user_id, 'rejected');
                    propsController.rejectedPropertyList.refresh();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
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
        : const ManageAllRejectedProperty();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColorPrimary,
          centerTitle: false,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          foregroundColor: Colors.white,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Property'),
              SizedBox(
                height: 3,
              ),
              Text(
                'Manage Property',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 2,
              ),
            ],
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade400,
            tabs: const [
              Tab(
                icon: Icon(Icons.star),
                text: 'All',
              ),
              Tab(
                icon: Icon(Icons.whatshot),
                text: 'Pending',
              ),
              Tab(
                icon: Icon(Icons.ac_unit),
                text: 'Approved',
              ),
              Tab(
                icon: Icon(Icons.cancel),
                text: 'Rejected',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  // Text('All'),
                  Obx(
                    () => (propsController.isAllProductProcessing == 'null')
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 30,
                            ),
                          )
                        : getAllProperty(),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _controller_2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  // Text('Pending'),
                  Obx(
                    () => (propsController.isPendingProductProcessing == 'null')
                        ? Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 30,
                            ),
                          )
                        : getPendingProperty(),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _controller_3,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  // Text('Approved'),
                  Obx(
                    () =>
                        (propsController.isApprovedProductProcessing == 'null')
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              )
                            : getApprovedProperty(),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _controller_4,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  // Text('Rejected'),
                  Obx(
                    () =>
                        (propsController.isApprovedProductProcessing == 'null')
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              )
                            : getRejectedProperty(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
