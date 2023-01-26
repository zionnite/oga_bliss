import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/request_model.dart';
import '../services/api_services.dart';
import '../util/common.dart';

class RequestController extends GetxController {
  RequestController get getXID => Get.find<RequestController>();

  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var requestList = <RequestModel>[].obs;

  String? user_id;
  bool? admin_status;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    admin_status = prefs.getBool('admin_status');
    await fetchRequest(page_num);
  }

  fetchRequest(pageNum) async {
    var seeker = await ApiServices.getRequest(pageNum, user_id, admin_status);
    if (seeker != null) {
      isDataProcessing(true);
      requestList.value = seeker.cast<RequestModel>();
    } else {
      isDataProcessing(false);
    }
  }

  fetchRequestMore(pageNum) async {
    var seeker = await ApiServices.getRequest(pageNum, user_id, admin_status);
    if (seeker != null) {
      isDataProcessing(true);
      requestList.addAll(seeker.cast<RequestModel>());
    } else {
      isDataProcessing(false);
    }
  }

  makeRequest({required String id, required String usersType}) async {
    String status = await ApiServices.makeRequest(id: id, usersType: usersType);

    bool status_type;
    String? msg;
    if (status == 'true') {
      msg = 'Request Marked';
      status_type = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      status_type = true;
    }
    showSnackBar(title: 'Make Request', msg: msg, backgroundColor: Colors.blue);

    return status_type;
  }

  setRequestStatus({
    required String id,
    required String statusType,
    required String disUserId,
    required String agentId,
    required String propsId,
  }) async {
    String status = await ApiServices.setRequestSetup(
      id: id,
      statusType: statusType,
      disUserId: disUserId,
      agentId: agentId,
      propsId: propsId,
      user_id: user_id!,
    );

    bool? status_type;
    String? msg;

    if (status == 'done') {
      msg = 'Connection Created between User and Agent';
      status_type = true;
    } else if (status == 'false') {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      status_type = false;
    } else if (status == 'existed') {
      msg = 'Connection already existed between user and Agent';
      status_type = false;
    } else if (status == 'rejected') {
      msg = 'Request rejected';
      status_type = true;
    } else if (status == 'review') {
      msg = 'Request in Review';
      status_type = true;
    } else if (status == 'confirm') {
      msg = 'Request is set to Confirm status';
      status_type = true;
    }

    showSnackBar(
        title: 'Request Status', msg: msg!, backgroundColor: Colors.blue);

    return status_type;
  }
}
