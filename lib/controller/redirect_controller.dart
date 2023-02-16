import 'package:get/get.dart';

class RedirectController extends GetxController {
  RedirectController get getXID => Get.find<RedirectController>();

  // final usersController = Get.put(UsersController());
  // final alertController = Get.put(AlertController());
  // final chatHeadController = Get.put(ChatHeadController());
  // final connectionController = Get.put(ConnectionController());
  // final dashboardController = Get.put(DashboardController());
  // final requestController = Get.put(RequestController());
  // final transactionController = Get.put(TransactionController());
  // final walletController = Get.put(WalletController());
  // final propertyController = Get.put(PropertyController());
  //
  // String? user_id;
  // bool? admin_status;
  // String? user_status;
  //
  // @override
  // void onInit() async {
  //   super.onInit();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   user_id = prefs.getString('user_id');
  //   admin_status = prefs.getBool('admin_status');
  //   user_status = prefs.getString('user_status');
  // }
  //
  // getAllControllers() async {
  //   await alertController.fetchAlert(1, user_id);
  //   await chatHeadController.fetchChatHead(1);
  //   await connectionController.fetchConnection(1);
  //   await dashboardController.getCounters(
  //     user_id,
  //     admin_status,
  //     user_status,
  //   );
  //   await requestController.fetchRequest(1);
  //   await transactionController.fetchTransaction(1);
  //   await usersController.getUsers(1);
  //   await usersController.getLandlord(1);
  //   await walletController.fetchWallet(1);
  //
  //   await propertyController.getDetails(user_id);
  //   await propertyController.fetchTypesProps();
  //
  //   await propertyController.fetch_favourite(1, user_id);
  //   await propertyController.getMyProduct(user_id);
  //   await propertyController.manageProduct(user_id, 'all');
  //   await propertyController.manageProduct(user_id, 'pending');
  //   await propertyController.manageProduct(user_id, 'approved');
  //   await propertyController.manageProduct(user_id, 'rejected');
  //
  //   print('called');
  // }
}
