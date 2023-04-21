import 'package:get/get.dart';

import '../../services/api_services.dart';
import '../bliss_model/account_report.dart';

class AccountReportController extends GetxController {
  AccountReportController get getXID => Get.find<AccountReportController>();

  var accountStatusCounter = <AccountReportModel>[].obs;
  var isDashboardProcessing = 'null'.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getCounters(userId, adminStatus, userStatus) async {
    var seeker =
        await ApiServices.countAccountReport(userId, adminStatus, userStatus);
    if (seeker != null) {
      isDashboardProcessing.value = 'yes';
      accountStatusCounter.value = seeker.cast<AccountReportModel>();
    } else {
      isDashboardProcessing.value = 'no';
    }
  }
}
