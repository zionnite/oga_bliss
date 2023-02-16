import 'package:get/get.dart';

import '../model/chat_head_model.dart';
import '../services/api_services.dart';

class ChatHeadController extends GetxController {
  ChatHeadController get getXID => Get.find<ChatHeadController>();

  var page_num = 1;

  var isChatHeadProcessing = 'null'.obs;
  var isMoreDataAvailable = true.obs;
  var chatHeadList = <ChatHeadModel>[].obs;
  var msgCounter = 0.obs;

  // String? user_id;
  // bool? admin_status;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // admin_status = prefs.getBool('admin_status');
    // await fetchChatHead(page_num);
  }

  fetchChatHead(pageNum, user_id) async {
    var seeker = await ApiServices.getChatHead(pageNum, user_id);
    if (seeker != null) {
      isChatHeadProcessing.value = 'yes';
      chatHeadList.value = seeker.cast<ChatHeadModel>();
    } else {
      isChatHeadProcessing.value = 'no';
    }
  }

  fetchChatHeadMore(pageNum, user_id) async {
    var seeker = await ApiServices.getChatHead(pageNum, user_id);
    if (seeker != null) {
      chatHeadList.addAll(seeker.cast<ChatHeadModel>());
    } else {}
  }

  checkForUpdate(var userId) async {
    var seeker = await ApiServices.countUnreadMsg(userId);
    if (seeker != null) {
      msgCounter.value = seeker;
    }
  }
}
