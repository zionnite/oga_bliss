import 'package:get/get.dart';
import 'package:oga_bliss/model/dashboard_model.dart';
import 'package:oga_bliss/services/api_services.dart';

class DashboardController extends GetxController {
  DashboardController get getXID => Get.find<DashboardController>();
  var counterList = <DashboardModel>[].obs;

  // String? user_id;
  // bool? admin_status;
  // String? user_status;

  var isDashboardProcessing = 'null'.obs;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // admin_status = prefs.getBool('admin_status');
    // user_status = prefs.getString('user_status');
    // await getCounters(user_id, admin_status, user_status);
  }

  getCounters(userId, adminStatus, userStatus) async {
    var seeker =
        await ApiServices.countDashboard(userId, adminStatus, userStatus);
    if (seeker != null) {
      isDashboardProcessing.value = 'yes';
      counterList.value = seeker.cast<DashboardModel>();
    } else {
      isDashboardProcessing.value = 'no';
    }
  }
}
