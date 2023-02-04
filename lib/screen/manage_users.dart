import 'package:flutter/material.dart';

import '../controller/users_controller.dart';
import 'manage/users/landlord.dart';
import 'manage/users/users.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({Key? key}) : super(key: key);

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  final usersController = UsersController().getXID;
  late ScrollController _controller;
  late ScrollController _controller_2;

  var user_id = 1;
  var current_page = 1;
  var current_page_landlord = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = usersController.isDataProcessing.value;
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

      usersController.getUsersMore(current_page);

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
        current_page_landlord++;
      });

      usersController.getLandLordsMore(current_page);

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('Users'),
              SizedBox(
                height: 3,
              ),
              Text(
                'Manage Users',
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
                icon: Icon(Icons.person),
                text: 'Users',
              ),
              Tab(
                icon: Icon(Icons.group),
                text: 'Landlords & Agent',
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
                  UsersPage(),
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
                  LandlordPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
