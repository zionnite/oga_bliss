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

  toggleDisableButton(userId, planCode, subCode, emailToken) async {
    String status = await ApiServices.toggleDisableButton(
        userId, planCode, subCode, emailToken);
    if (userId == null) {
      showSnackBar(
        title: 'Oops!',
        msg: 'You need to Login before you can perform this action',
        backgroundColor: Colors.blue.shade900,
      );
      return 'false';
    }

    if (status == 'true') {
      showSnackBar(
        title: "Note",
        msg: 'Subscription Disable',
        backgroundColor: Colors.blue.shade900,
      );
      return 'true';
    } else if (status == 'false_0') {
      showSnackBar(
        title: "Note",
        msg: 'You already disable this subscription',
        backgroundColor: Colors.red,
      );
      return 'false_0';
    } else if (status == 'false_1') {
      showSnackBar(
        title: "Note",
        msg: 'Could not disable subscription please try again later!',
        backgroundColor: Colors.red,
      );
      return 'false_1';
    } else if (status == 'false_2') {
      showSnackBar(
        title: "Note",
        msg: 'Your subscription is disabled but could not update your profile',
        backgroundColor: Colors.red,
      );
      return 'false_2';
    }
  }

  updateCard(userId, subCode) async {
    String status = await ApiServices.toggleUpdateCard(userId, subCode);
    if (userId == null) {
      showSnackBar(
        title: 'Oops!',
        msg: 'You need to Login before you can perform this action',
        backgroundColor: Colors.blue.shade900,
      );
      return 'false';
    }

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
