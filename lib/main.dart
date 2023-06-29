import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/count_subscription_item_controller.dart';
import 'package:oga_bliss/bliss_legacy/bliss_controller/point_controller.dart';
import 'package:oga_bliss/controller/dashboard_controller.dart';
import 'package:oga_bliss/controller/market_controller.dart';
import 'package:oga_bliss/controller/redirect_controller.dart';
import 'package:oga_bliss/controller/withdrawal_controller.dart';
import 'package:oga_bliss/screen/front/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bliss_legacy/bliss_controller/account_report_controller.dart';
import 'bliss_legacy/bliss_controller/bliss_downline_controller.dart';
import 'bliss_legacy/bliss_controller/bliss_transaction_controller.dart';
import 'bliss_legacy/bliss_controller/shop_controller.dart';
import 'bliss_legacy/bliss_controller/subscription_controller.dart';
import 'controller/alert_controller.dart';
import 'controller/chat_head_controller.dart';
import 'controller/connection_controller.dart';
import 'controller/favourite_controller.dart';
import 'controller/onboarding_controller.dart';
import 'controller/property_controller.dart';
import 'controller/request_controller.dart';
import 'controller/splash_controller.dart';
import 'controller/transaction_controller.dart';
import 'controller/users_controller.dart';
import 'controller/wallet_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(SplashController());
  Get.put(OnboardingCongroller());
  Get.put(PropertyController());
  Get.put(FavouriteController());
  Get.put(RequestController());
  Get.put(ConnectionController());
  Get.put(TransactionController());
  Get.put(AlertController());
  Get.put(ChatHeadController());
  Get.put(WalletController());
  Get.put(UsersController());
  Get.put(DashboardController());
  Get.put(RedirectController());
  Get.put(BlissTransactionController());
  Get.put(AccountReportController());
  Get.put(BlissDownlineController());
  Get.put(ShopController());
  Get.put(SubscriptionController());
  Get.put(CountSubscriptionItemController());
  Get.put(PointItemController());
  Get.put(WithdrawalController());
  Get.put(MarketController());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isUserLogin = prefs.getBool('isUserLogin');
  var isFirstTime = prefs.getBool('isFirstTime');
  var userId1 = prefs.getString('user_id');
  var demoStatus = prefs.getBool("displayShowCase");
  runApp(
    RestartWidget(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(
          isUserLogin: isUserLogin,
          isFirstTIme: isFirstTime,
          userId: userId1,
          demoStatus: demoStatus,
        ),
      ),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({
    required this.isUserLogin,
    required this.isFirstTIme,
    required this.userId,
    required this.demoStatus,
  });

  late var isUserLogin;
  late var isFirstTIme;
  late var userId;
  late var demoStatus;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('status', true);
    // prefs.setBool('validation', true);
    // prefs.setString('user_status', "user");
    // prefs.setString('online_status', "online");
  }

  @override
  Widget build(BuildContext context) {
    addStringToSF();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}
