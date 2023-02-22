import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oga_bliss/screen/view_propert_detailed_dash.dart';
import 'package:oga_bliss/widget/show_not_found.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/wallet_controller.dart';
import '../widget/fund_wallet.dart';
import '../widget/notice_me.dart';
import '../widget/property_app_bar.dart';
import '../widget/property_btn_icon.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final walletController = WalletController().getXID;
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

      await walletController.fetchWallet(1, user_id, user_status);
    }
  }

  var current_page = 1;
  bool isLoading = false;
  bool widgetLoading = true;

  checkIfListLoaded() {
    var loading = walletController.isWalletProcessing;
    if (loading == 'yes' || loading == 'no') {
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

      walletController.fetchWalletMore(current_page, user_id, user_status);

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
      body: Column(
        children: [
          const PropertyAppBar(title: 'Wallet'),
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  NoticeMe(
                    title: 'Oops!',
                    desc: 'Your bank account is not yet verify!',
                    icon: Icons.warning,
                    icon_color: Colors.red,
                    border_color: Colors.red,
                    btnTitle: 'Verify Now',
                    btnColor: Colors.blue,
                    onTap: () {},
                  ),
                  PropertyBtnIcon(
                    onTap: () {
                      String link =
                          'https://ogabliss.com/Wallet/auth_user/$user_id';
                      _launchInBrowser(Uri.parse(link));
                    },
                    title: 'Fund Wallet',
                    bgColor: Colors.blue,
                    icon: Icons.wallet_sharp,
                    icon_color: Colors.white,
                    icon_size: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => (walletController.isWalletProcessing == 'null')
                        ? LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.blue,
                            size: 20,
                          )
                        : detail(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget detail() {
    return (walletController.walletList.isEmpty)
        ? Stack(children: [
            const ShowNotFound(),
            Positioned(
              bottom: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  setState(() {
                    walletController.isWalletProcessing.value = 'null';
                    walletController.fetchWallet(1, user_id, user_status);
                    walletController.walletList.refresh();
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
        : Obx(() => ListView.builder(
              padding: const EdgeInsets.only(bottom: 120),
              key: const PageStorageKey<String>('allWallet'),
              physics: const ClampingScrollPhysics(),
              // itemExtent: 350,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: walletController.walletList.length,
              itemBuilder: (BuildContext context, int index) {
                var wallet = walletController.walletList[index];

                if (walletController.walletList[index].id == null) {
                  return Container();
                }
                return fundWallet(
                  walletModel: wallet,
                  image_name: wallet.propsImage!,
                  name: wallet.propsName!,
                  time: wallet.time!,
                  amount: wallet.amount!,
                  onTap: () {
                    Get.to(
                      () => ViewPropertyDetailedDashboard(
                        propsId: wallet.propsId!,
                        route: 'dashboard',
                      ),
                    );
                  },
                );
              },
            ));
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
