import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/model/withdrawal_model.dart';
import 'package:oga_bliss/services/api_services.dart';
import 'package:oga_bliss/util/common.dart';

class WithdrawalController extends GetxController {
  WithdrawalController get getXID => Get.find<WithdrawalController>();

  var page_num = 1;
  var isWithdrawalProcessing = 'null'.obs;
  var isMoreDataAvailable = true.obs;
  var withdrawalList = <Withdrawal>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  fetchWithdrawal(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getWithdrawal(pageNum, user_id, admin_status);
    if (seeker != null) {
      isWithdrawalProcessing.value = 'yes';
      withdrawalList.value = seeker.cast<Withdrawal>();
    } else {
      isWithdrawalProcessing.value = 'no';
    }
  }

  fetchWithdrawalMore(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getWithdrawal(pageNum, user_id, admin_status);
    if (seeker != null) {
      withdrawalList.addAll(seeker.cast<Withdrawal>());
    } else {}
  }

  Future<void> requestWithdrawal({
    required String userId,
    required String amount,
  }) async {
    String status =
        await ApiServices.requestWithdrawal(userId: userId, amount: amount);
    showSnackBar(
        title: 'Request',
        msg: status,
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 10));
  }

  Future<String> approveWithdrawalRequest({
    required String disUserId,
    required String id,
  }) async {
    String status = await ApiServices.approveWithdrawalRequest(
        disUserId: disUserId, Id: id);

    return status;
  }

  Future<String> rejectWithdrawalRequest({
    required String disUserId,
    required String id,
  }) async {
    String status =
        await ApiServices.rejectWithdrawalRequest(disUserId: disUserId, Id: id);
    return status;
  }
}
