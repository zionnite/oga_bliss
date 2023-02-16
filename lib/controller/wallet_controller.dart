import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/model/wallet_model.dart';

import '../services/api_services.dart';
import '../util/common.dart';

class WalletController extends GetxController {
  WalletController get getXID => Get.find<WalletController>();

  var page_num = 1;
  var isWalletProcessing = 'null'.obs;
  var isMoreDataAvailable = true.obs;
  var walletList = <WalletModel>[].obs;

  // String? user_id;
  // bool? admin_status;
  // String? user_status;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // admin_status = prefs.getBool('admin_status');
    // user_status = prefs.getString('user_status');
    // await fetchWallet(page_num);
  }

  fetchWallet(pageNum, user_id, user_status) async {
    var seeker = await ApiServices.getWallet(pageNum, user_id, user_status);
    if (seeker != null) {
      isWalletProcessing.value = 'yes';
      walletList.value = seeker.cast<WalletModel>();
    } else {
      isWalletProcessing.value = 'no';
    }
  }

  fetchWalletMore(pageNum, user_id, user_status) async {
    var seeker = await ApiServices.getWallet(pageNum, user_id, user_status);
    if (seeker != null) {
      walletList.addAll(seeker.cast<WalletModel>());
    } else {}
  }

  pullOutRequest({
    required String propsId,
    required String agentId,
    required String userId,
  }) async {
    String status = await ApiServices.pullOut(
      propsId: propsId,
      agentId: agentId,
      userId: userId,
    );

    String? statusType;
    String? msg;
    if (status == 'transfer') {
      msg = 'Pull Out successful, transfer has been added to queue!';
      statusType = 'transfer';
    } else if (status == 'not_transfer') {
      msg =
          'Transaction failed, could not carryout pull-out transfer,please try again later!';
      statusType = 'not_transfer';
    } else if (status == 'requested') {
      msg = 'You have already requested for  a Pull-Out, please be Patient';
      statusType = 'requested';
    } else {
      msg = 'You have already initiated a Payment Settlement with this Agent ';
      statusType = 'initiated';
    }

    showSnackBar(
        title: 'Wallet Request', msg: msg, backgroundColor: Colors.blue);

    return statusType;
  }
}
