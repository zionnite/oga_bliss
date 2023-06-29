import 'package:get/get.dart';
import 'package:oga_bliss/model/transaction_model.dart';

import '../services/api_services.dart';

class TransactionController extends GetxController {
  TransactionController get getXID => Get.find<TransactionController>();

  var page_num = 1;
  var isTransactionProcessing = 'null'.obs;
  var isMoreDataAvailable = true.obs;
  var propsTransactionList = <PropertyTransaction>[].obs;

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
      isTransactionProcessing.value = 'yes';
      propsTransactionList.value = seeker.cast<PropertyTransaction>();
      print('came here ');
    } else {
      print('came there');
      isTransactionProcessing.value = 'no';
    }
  }

  fetchTransactionMore(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getTransaction(pageNum, user_id, admin_status);
    if (seeker != null) {
      propsTransactionList.addAll(seeker.cast<PropertyTransaction>());
    } else {}
  }
}
