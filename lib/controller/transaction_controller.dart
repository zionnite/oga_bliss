import 'package:get/get.dart';

import '../model/transaction_model.dart';
import '../services/api_services.dart';

class TransactionController extends GetxController {
  TransactionController get getXID => Get.find<TransactionController>();

  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var transactionList = <TransactionModel>[].obs;

  // String? user_id;
  // bool? admin_status;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // admin_status = prefs.getBool('admin_status');
    // await fetchTransaction(page_num);
  }

  fetchTransaction(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getTransaction(pageNum, user_id, admin_status);
    if (seeker != null) {
      isDataProcessing(true);
      transactionList.value = seeker.cast<TransactionModel>();
    } else {
      isDataProcessing(false);
    }
  }

  fetchTransactionMore(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getTransaction(pageNum, user_id, admin_status);
    if (seeker != null) {
      isDataProcessing(true);
      transactionList.addAll(seeker.cast<TransactionModel>());
    } else {
      isDataProcessing(false);
    }
  }
}
