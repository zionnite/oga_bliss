import 'package:get/get.dart';

import '../../services/api_services.dart';
import '../bliss_model/count_subscription_item.dart';

class CountSubscriptionItemController extends GetxController {
  CountSubscriptionItemController get getXID =>
      Get.find<CountSubscriptionItemController>();

  var subscriptionItemCounter = <CountSubscriptionItem>[].obs;
  var userSubscriptionItemCounter = <CountSubscriptionItem>[].obs;
  var isSubscriptionItemProcessing = 'null'.obs;
  var isUserSubscriptionItemProcessing = 'null'.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getCountSubscriptionItems(userId, planId) async {
    var seeker = await ApiServices.countSubscriptionItems(userId, planId);
    if (seeker != null) {
      isSubscriptionItemProcessing.value = 'yes';
      subscriptionItemCounter.value = seeker.cast<CountSubscriptionItem>();
    } else {
      isSubscriptionItemProcessing.value = 'no';
    }
  }

  getUserCountSubscriptionItems(userId, planId) async {
    // userSubscriptionItemCounter.clear();
    isUserSubscriptionItemProcessing.value = 'null';
    var seeker = await ApiServices.countSubscriptionItems(userId, planId);
    if (seeker != null) {
      isUserSubscriptionItemProcessing.value = 'yes';
      userSubscriptionItemCounter.value = seeker.cast<CountSubscriptionItem>();
    } else {
      isUserSubscriptionItemProcessing.value = 'no';
    }
  }
}
