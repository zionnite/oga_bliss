import 'package:flutter/material.dart';

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

  var user_id = 1;
  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = propsController.isDataProcessing.value;
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
    _controller_2 = ScrollController()..addListener(_scrollListener_2);

    Future.delayed(new Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          checkIfListLoaded();
        });
      }
    });

    // propsController.getDetails(1);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      propsController.getMoreDetail(current_page, user_id);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void _scrollListener_2() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      propsController.getMoreDetail(current_page, user_id);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
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
                icon: Icon(Icons.ac_unit),
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
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  // Text('Weekly Prayer Chart'),
                  ManageAllProperty(),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _controller_2,
              child: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Monthly Prayer Chart'),
                  ManageAllPendingProperty(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Total Prayer Chart'),
                  ManageAllApprovedProperty(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Total Prayer Chart'),
                  ManageAllRejectedProperty(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
