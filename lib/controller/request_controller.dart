import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/request_model.dart';
import '../services/api_services.dart';

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
}
