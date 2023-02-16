import 'package:get/get.dart';

import '../model/connection_model.dart';
import '../services/api_services.dart';

class ConnectionController extends GetxController {
  ConnectionController get getXID => Get.find<ConnectionController>();

  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var connectionList = <ConnectionModel>[].obs;

  // String? user_id;
  // bool? admin_status;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // admin_status = prefs.getBool('admin_status');
    // await fetchConnection(page_num);
  }

  fetchConnection(pageNum, user_id) async {
    var seeker = await ApiServices.getConnection(pageNum, user_id);

    if (seeker != null) {
      isDataProcessing(true);
      connectionList.value = seeker.cast<ConnectionModel>();
    } else {
      isDataProcessing(false);
    }
  }

  fetchConnectionMore(pageNum, user_id) async {
    var seeker = await ApiServices.getConnection(pageNum, user_id);

    if (seeker != null) {
      isDataProcessing(true);
      connectionList.addAll(seeker.cast<ConnectionModel>());
    } else {
      isDataProcessing(false);
    }
  }
}
