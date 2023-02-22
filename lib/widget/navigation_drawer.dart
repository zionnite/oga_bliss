import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/controller/users_controller.dart';
import 'package:oga_bliss/screen/alert_page.dart';
import 'package:oga_bliss/screen/connection_page.dart';
import 'package:oga_bliss/screen/favourite.dart';
import 'package:oga_bliss/screen/front/decide_page.dart';
import 'package:oga_bliss/screen/front/login_page.dart';
import 'package:oga_bliss/screen/message_page.dart';
import 'package:oga_bliss/screen/profile_page.dart';
import 'package:oga_bliss/screen/request_page.dart';
import 'package:oga_bliss/screen/transaction_page.dart';
import 'package:oga_bliss/screen/wallet.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/dashboard.dart';
import '../screen/front/splash_page.dart';
import '../screen/front/welcome_page.dart';
import '../screen/manage_property.dart';
import '../screen/manage_users.dart';
import '../screen/product_property_page.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final usersController = UsersController().getXID;

  final padding = const EdgeInsets.symmetric(horizontal: 20);
  String? user_id;
  String? user_status;
  String? user_name;
  String? fullName;
  String? image_name;
  bool? admin_status;

  initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId1 = prefs.getString('user_id');
    var userStatus1 = prefs.getString('user_status');
    var adminStatus1 = prefs.getBool('admin_status');
    var imageName1 = prefs.getString('image_name');
    var userName1 = prefs.getString('user_name');
    var fullName1 = prefs.getString('full_name');

    if (mounted) {
      setState(() {
        user_id = userId1;
        user_status = userStatus1;
        admin_status = adminStatus1;
        image_name = imageName1;
        user_name = userName1;
        fullName = fullName1;
      });
    }
  }

  @override
  void initState() {
    initUserDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: '${image_name}',
              name: '${fullName}',
              email: '${user_name}',
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // buildSearchField(),
                  buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.dashboard,
                    onClicked: () {
                      Get.to(
                        () => const DashboardPage(),
                      );
                    },
                  ),

                  /*Admin*/
                  adminWidget(),
                  usersWidget(),

                  /*End Admin*/
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Request',
                    icon: Icons.waving_hand_sharp,
                    onClicked: () => Get.to(
                      () => const RequestPage(),
                    ),
                  ),

                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Transaction',
                    icon: Icons.receipt_long,
                    onClicked: () => Get.to(
                      () => const TransactionPage(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),

                  bottomWidget(),

                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Alert',
                    icon: Icons.notifications_outlined,
                    onClicked: () => Get.to(
                      () => const AlertPage(),
                    ),
                  ),
                  // extraWidget(),
                  const SizedBox(height: 24),
                  (admin_status == false)
                      ? const Divider(color: Colors.white70)
                      : Container(),

                  (admin_status == false)
                      ? buildMenuItem(
                          text: 'Delete Account',
                          icon: Icons.delete,
                          onClicked: () {
                            // Navigator.pop(context);
                            PanaraConfirmDialog.show(
                              context,
                              title: "Are You Sure?",
                              message:
                                  "Do you really want to Delete your account?, you will not be able to undo this action.",
                              confirmButtonText: "Confirm",
                              cancelButtonText: "Cancel",
                              onTapCancel: () {
                                Navigator.pop(context);
                              },
                              onTapConfirm: () async {
                                bool status = await usersController
                                    .deleteAccount(user_id);
                                if (status || !status) {
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              panaraDialogType: PanaraDialogType.normal,
                              barrierDismissible:
                                  false, // optional parameter (default is true)
                            );
                          },
                        )
                      : Container(),

                  (admin_status == false)
                      ? const SizedBox(height: 35)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  urlImage,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      child: Text(
                        name,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget adminWidget() {
    return (admin_status == true)
        ? Column(
            children: [
              const SizedBox(height: 24),
              buildMenuItem(
                text: 'Manage Product',
                icon: Icons.shopping_bag,
                onClicked: () => Get.to(
                  () => const ManageProperty(),
                ),
              ),
              const SizedBox(height: 24),
              buildMenuItem(
                text: 'Manage Users',
                icon: Icons.person,
                onClicked: () => Get.to(
                  () => const ManageUsers(),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget usersWidget() {
    return (admin_status == false)
        ? Column(
            children: [
              (user_status == 'agent' || user_status == 'landlord')
                  ? const SizedBox(height: 24)
                  : Container(),
              (user_status == 'agent' || user_status == 'landlord')
                  ? buildMenuItem(
                      text: 'Product',
                      icon: Icons.shopping_bag,
                      onClicked: () => Get.to(
                        () => const ProductPropertyPage(),
                      ),
                    )
                  : Container(),
              (user_status == 'user')
                  ? const SizedBox(height: 16)
                  : Container(),
              (user_status == 'user')
                  ? buildMenuItem(
                      text: 'Wallet',
                      icon: Icons.wallet,
                      onClicked: () => Get.to(
                        () => const WalletPage(),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 16),
              buildMenuItem(
                text: 'Connection',
                icon: Icons.account_tree_outlined,
                onClicked: () => Get.to(
                  () => const ConnectionPage(),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget bottomWidget() {
    return (admin_status == false)
        ? Column(
            children: [
              const SizedBox(height: 24),
              buildMenuItem(
                text: 'Message',
                icon: Icons.message,
                onClicked: () => Get.to(
                  () => const MessagePage(),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget buildSearchField() {
    const color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 21, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget extraWidget() {
    return Column(
      children: [
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Login Page',
          icon: Icons.notifications_outlined,
          onClicked: () => Get.to(
            () => const LoginPage(),
          ),
        ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Signup Page',
          icon: Icons.notifications_outlined,
          onClicked: () => Get.to(
            () => const DecidePage(),
          ),
        ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Welcome Page',
          icon: Icons.notifications_outlined,
          onClicked: () => Get.to(
            () => const WelcomePage(),
          ),
        ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Onboarding Screen',
          icon: Icons.notifications_outlined,
          onClicked: () => Get.to(
            () => const LoginPage(),
          ),
        ),
        const SizedBox(height: 16),
        buildMenuItem(
          text: 'Splash Screen',
          icon: Icons.notifications_outlined,
          onClicked: () => Get.to(
            () => SplashPage(),
          ),
        ),
      ],
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ));

        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritePage(),
        ));
        break;
    }
  }
}
