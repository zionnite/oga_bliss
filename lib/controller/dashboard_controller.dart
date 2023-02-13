import 'package:get/get.dart';
import 'package:oga_bliss/model/dashboard_model.dart';
import 'package:oga_bliss/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  DashboardController get getXID => Get.find<DashboardController>();
  var counterList = <DashboardModel>[].obs;

  String? user_id;
  bool? admin_status;
  String? user_status;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    admin_status = prefs.getBool('admin_status');
    user_status = prefs.getString('user_status');
    await getCounters(user_id, admin_status, user_status);
  }

  getCounters(userId, adminStatus, userStatus) async {
    print('called');
    var seeker =
        await ApiServices.countDashboard(userId, adminStatus, userStatus);
    if (seeker != null) {
      counterList.value = seeker.cast<DashboardModel>();
    }
  }
}
