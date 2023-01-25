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
    showSnackBar(
        title: 'Make Request', msg: status, backgroundColor: Colors.blue);
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
    );
    showSnackBar(
        title: 'Request Status', msg: status, backgroundColor: Colors.blue);
  }
}
