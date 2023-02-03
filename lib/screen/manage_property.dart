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
  late ScrollController _controller_3;
  late ScrollController _controller_4;

  var user_id = 1;
  var current_page = 1;
  var current_page_pending = 1;
  var current_page_approved = 1;
  var current_page_rejected = 1;
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
    _controller_3 = ScrollController()..addListener(_scrollListener_3);
    _controller_4 = ScrollController()..addListener(_scrollListener_4);

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
    if (_controller_2.position.pixels ==
        _controller_2.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page_pending++;
      });

      print('current page pending $current_page_pending');
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

      print('current page approved $current_page_approved');
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

      print('current page rejected $current_page_rejected');

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
                  // Text('All'),
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
                  // Text('Pending'),
                  ManageAllPendingProperty(),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _controller_3,
              child: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  // Text('Approved'),
                  ManageAllApprovedProperty(),
                ],
              ),
            ),
            SingleChildScrollView(
              controller: _controller_4,
              child: Column(
                children: const [
                  SizedBox(
                    height: 5,
                  ),
                  // Text('Rejected'),
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
