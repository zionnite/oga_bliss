import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/card_activities.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/subscription_list_model.dart';
import 'package:oga_bliss/services/api_services.dart';
import 'package:oga_bliss/util/common.dart';

class SubscriptionController extends GetxController {
  SubscriptionController get getXID => Get.find<SubscriptionController>();

  var page_num = 1;
  var isMyPlaProcessing = 'null'.obs;
  var isUserPlaProcessing = 'null'.obs;
  var isUCardProcessing = 'null'.obs;
  var myPlanList = <MyPlanList>[].obs;
  var userPlanList = <MyPlanList>[].obs;
  var cardActivitiesList = <Subscription>[].obs;
  var userCardActivitiesList = <Subscription>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getPlanList(pageNum, userId) async {
    var seeker = await ApiServices.getSubscription(pageNum, userId);
    if (seeker != null) {
      isMyPlaProcessing.value = 'yes';
      myPlanList.value = seeker.cast<MyPlanList>();
    } else {
      isMyPlaProcessing.value = 'no';
    }
  }

  getPlanListMore(pageNum, userId) async {
    var seeker = await ApiServices.getSubscription(pageNum, userId);
    if (seeker != null) {
      myPlanList.addAll(seeker.cast<MyPlanList>());
    } else {}
  }

  getUserPlanList(pageNum, userId) async {
    userPlanList.clear();
    isUserPlaProcessing.value = 'null';
    var seeker = await ApiServices.getSubscription(pageNum, userId);
    if (seeker != null) {
      isUserPlaProcessing.value = 'yes';
      userPlanList.value = seeker.cast<MyPlanList>();
    } else {
      isUserPlaProcessing.value = 'no';
    }
  }

  getUserPlanListMore(pageNum, userId) async {
    var seeker = await ApiServices.getSubscription(pageNum, userId);
    if (seeker != null) {
      userPlanList.value = seeker.cast<MyPlanList>();
    } else {}
  }

  getCardActivities(pageNum, planId, userId) async {
    cardActivitiesList.clear();
    var seeker = await ApiServices.getCardActivity(pageNum, planId, userId);
    if (seeker != null) {
      isMyPlaProcessing.value = 'yes';
      cardActivitiesList.value = seeker.cast<Subscription>();
    } else {
      isMyPlaProcessing.value = 'no';
    }
  }

  getCardActivitiesMore(pageNum, planId, userId) async {
    var seeker = await ApiServices.getCardActivity(pageNum, planId, userId);
    if (seeker != null) {
      cardActivitiesList.addAll(seeker.cast<Subscription>());
    } else {}
  }

  getUserCardActivities(pageNum, planId, userId) async {
    userCardActivitiesList.clear();
    isUCardProcessing.value = 'null';
    var seeker = await ApiServices.getCardActivity(pageNum, planId, userId);
    if (seeker != null) {
      isUCardProcessing.value = 'yes';
      userCardActivitiesList.value = seeker.cast<Subscription>();
    } else {
      isUCardProcessing.value = 'no';
    }
  }

  getUserCardActivitiesMore(pageNum, planId, userId) async {
    var seeker = await ApiServices.getCardActivity(pageNum, planId, userId);
    if (seeker != null) {
      userCardActivitiesList.addAll(seeker.cast<Subscription>());
    } else {}
  }

  toggleDisableButton({
    required String disId,
    required String userId,
    required String planId,
    required String planCode,
    required String subCode,
    required String emailToken,
    required MyPlanList planList,
  }) async {
    String status = await ApiServices.toggleDisableButton(
      disId: disId,
      userId: userId,
      planId: planId,
      planCode: planCode,
      subCode: subCode,
      emailToken: emailToken,
    );

    if (status == 'true_1') {
      // int index = myPlanList.indexOf(planList);
      // print(index);
      // print('count ${myPlanList.length}');
      //myPlanList.removeAt(index);
      //myPlanList.refresh();

      // var id = myPlanList[index].id;
      // var newPropId = myPlanList.indexWhere(((p) => p.id == id));
      // if (newPropId != -1) {
      //   myPlanList.removeAt(newPropId);
      // }

      showSnackBar(
        title: "Result",
        msg: 'Since Plan is INACTIVE we removed it from list',
        backgroundColor: Colors.blue.shade900,
      );
    } else if (status == 'true_2') {
      showSnackBar(
        title: "Result",
        msg: 'Request submitted awaiting Admin approval',
        backgroundColor: Colors.blue.shade900,
      );
    } else if (status == 'false' || status == 'false_2') {
      showSnackBar(
        title: "Result",
        msg: 'Database busy, please try again later',
        backgroundColor: Colors.blue.shade900,
      );
    } else {
      showSnackBar(
        title: "Result",
        msg: 'You already initiated this request with this subscription plan',
        backgroundColor: Colors.blue.shade900,
      );
    }

    return status;
  }

  //$dis_id = NULL, $user_id = NULL, $plan_id = NULL, $plan_code = NULL, $sub_code = NULL, $email_token = NULL
  updateCard(userId, subCode) async {
    String status = await ApiServices.toggleUpdateCard(userId, subCode);

    if (status == 'true') {
      showSnackBar(
        title: "Note",
        msg:
            'A Link has been sent to you, click on the link and follow the Instruction',
        backgroundColor: Colors.blue.shade900,
      );
      return 'true';
    } else if (status == 'false') {
      showSnackBar(
        title: "Note",
        msg: 'Could not perform operation, please try again later',
        backgroundColor: Colors.red,
      );
      return 'false';
    }
  }
}
