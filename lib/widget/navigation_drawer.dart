import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/screen/alert_page.dart';
import 'package:oga_bliss/screen/connection_page.dart';
import 'package:oga_bliss/screen/favourite.dart';
import 'package:oga_bliss/screen/front/login_page.dart';
import 'package:oga_bliss/screen/front/signup_page.dart';
import 'package:oga_bliss/screen/message_page.dart';
import 'package:oga_bliss/screen/profile_page.dart';
import 'package:oga_bliss/screen/request_page.dart';
import 'package:oga_bliss/screen/transaction_page.dart';
import 'package:oga_bliss/screen/wallet.dart';

import '../screen/dashboard.dart';
import '../screen/front/splash_page.dart';
import '../screen/front/welcome_page.dart';
import '../screen/product_property_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    const name = 'Sarah Abs';
    const email = 'sarah@abs.com';
    const urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(),
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
                        () => DashboardPage(),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Product',
                    icon: Icons.shopping_bag,
                    onClicked: () => Get.to(
                      () => const ProductPropertyPage(),
                    ),
                  ),
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
                    text: 'Wallet',
                    icon: Icons.wallet,
                    onClicked: () => Get.to(
                      () => const WalletPage(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Connection',
                    icon: Icons.account_tree_outlined,
                    onClicked: () => Get.to(
                      () => const ConnectionPage(),
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
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Message',
                    icon: Icons.message,
                    onClicked: () => Get.to(
                      () => const MessagePage(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Alert',
                    icon: Icons.notifications_outlined,
                    onClicked: () => Get.to(
                      () => const AlertPage(),
                    ),
                  ),
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
                      () => const SignupPage(),
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
                  const SizedBox(height: 30),
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
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade300,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      );

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
