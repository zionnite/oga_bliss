import 'package:get/get.dart';
import 'package:oga_bliss/services/api_services.dart';

import '../bliss_model/bliss_transaction_model.dart';

class BlissTransactionController extends GetxController {
  BlissTransactionController get getXID =>
      Get.find<BlissTransactionController>();

  var page_num = 1;
  var isBlissTransactionProcessing = 'null'.obs;
  var transactionList = <Transaction>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  fetchTransaction(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getBlissTransaction(pageNum, user_id, admin_status);
    if (seeker != null) {
      isBlissTransactionProcessing.value = 'yes';
      transactionList.value = seeker.cast<Transaction>();
    } else {
      isBlissTransactionProcessing.value = 'no';
    }
  }

  fetchTransactionMore(pageNum, user_id, admin_status) async {
    var seeker =
        await ApiServices.getBlissTransaction(pageNum, user_id, admin_status);
    if (seeker != null) {
      transactionList.addAll(seeker.cast<Transaction>());
    } else {}
  }
}
