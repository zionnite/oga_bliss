import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/bliss_downline_model.dart';

import '../../services/api_services.dart';

class BlissDownlineController extends GetxController {
  BlissDownlineController get getXID => Get.find<BlissDownlineController>();

  var page_num = 1;
  var isBUProcessing = 'null'.obs;
  var isUVProcessing = 'null'.obs;
  var usersList = <User>[].obs;
  var viewUsersList = <User>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getUsers(pageNum, userId) async {
    var seeker = await ApiServices.getDownline(pageNum, userId);
    if (seeker != null) {
      isBUProcessing.value = 'yes';
      usersList.value = seeker.cast<User>();
    } else {
      isBUProcessing.value = 'no';
    }
  }

  getUsersMore(pageNum, userId) async {
    var seeker = await ApiServices.getDownline(pageNum, userId);
    if (seeker != null) {
      usersList.addAll(seeker.cast<User>());
    } else {}
  }

  getUsersDownline(pageNum, userId) async {
    viewUsersList.clear();
    isUVProcessing.value = 'null';

    var seeker = await ApiServices.getDownline(pageNum, userId);
    if (seeker != null) {
      isUVProcessing.value = 'yes';
      viewUsersList.value = seeker.cast<User>();
    } else {
      isUVProcessing.value = 'no';
    }
  }

  getUsersDownlineMore(pageNum, userId) async {
    var seeker = await ApiServices.getDownline(pageNum, userId);
    if (seeker != null) {
      viewUsersList.value = seeker.cast<User>();
    } else {}
  }
}
