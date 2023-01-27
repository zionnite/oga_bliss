import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/chat_head_model.dart';
import '../services/api_services.dart';

class ChatHeadController extends GetxController {
  ChatHeadController get getXID => Get.find<ChatHeadController>();

  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var chatHeadList = <ChatHeadModel>[].obs;

  String? user_id;
  bool? admin_status;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    admin_status = prefs.getBool('admin_status');
    await fetchChatHead(page_num);
  }

  fetchChatHead(pageNum) async {
    var seeker = await ApiServices.getChatHead(pageNum, user_id);
    if (seeker != null) {
      isDataProcessing(true);
      chatHeadList.value = seeker.cast<ChatHeadModel>();
    } else {
      isDataProcessing(false);
    }
  }

  fetchChatHeadMore(pageNum) async {
    var seeker = await ApiServices.getChatHead(pageNum, user_id);
    if (seeker != null) {
      isDataProcessing(true);
      chatHeadList.addAll(seeker.cast<ChatHeadModel>());
    } else {
      isDataProcessing(false);
    }
  }
}
