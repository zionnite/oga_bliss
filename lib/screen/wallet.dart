import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PropertyAppBar(title: 'Wallet'),
          Expanded(
            child: SingleChildScrollView(
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
                    onTap: () {},
                    title: 'Fund Wallet',
                    bgColor: Colors.blue,
                    icon: Icons.wallet_sharp,
                    icon_color: Colors.white,
                    icon_size: 20,
                  ),
                  fundWallet(
                    image_name:
                        'https://ogabliss.com/project_dir/property/45164d94bc96f243362af5468841cd44.jpg',
                    name: 'Property name',
                    time: '5mins Ago',
                    amount: '30000',
                    onTap: () {
                      print('images cliceked');
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
