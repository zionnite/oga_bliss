import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/alert_model.dart';
import '../services/api_services.dart';
import '../util/common.dart';

class AlertController extends GetxController {
  AlertController get getXID => Get.find<AlertController>();

  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var alertList = <AlertModel>[].obs;
  var alertCounter = 0.obs;

  // String? user_id;
  // bool? admin_status;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // admin_status = prefs.getBool('admin_status');
    // await fetchAlert(page_num);
  }

  fetchAlert(pageNum, user_id) async {
    var seeker = await ApiServices.getAlerts(pageNum, user_id);
    if (seeker != null) {
      isDataProcessing(true);
      alertList.value = seeker.cast<AlertModel>();
    } else {
      isDataProcessing(false);
    }
  }

  fetchAlertMore(pageNum, user_id) async {
    var seeker = await ApiServices.getAlerts(pageNum, user_id);
    if (seeker != null) {
      isDataProcessing(true);
      alertList.addAll(seeker.cast<AlertModel>());
    } else {
      isDataProcessing(false);
    }
  }

  deleteAlert({required String id}) async {
    String status = await ApiServices.deleteAlert(id: id);

    bool statusType;
    String? msg;
    if (status == 'true') {
      msg = 'Deleted';
      statusType = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = true;
    }
    showSnackBar(title: msg, msg: '', backgroundColor: Colors.blue);

    return statusType;
  }

  checkForUpdate(var userId) async {
    var seeker = await ApiServices.countUnreadAlert(userId);
    if (seeker != null) {
      alertCounter.value = seeker;
    }
  }
}
