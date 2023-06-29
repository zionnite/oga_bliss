import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/services/api_services.dart';
import 'package:oga_bliss/util/common.dart';

import '../bliss_model/subscription_plan_model.dart';

class ShopController extends GetxController {
  ShopController get getXID => Get.find<ShopController>();

  var page_num = 1;
  var isShoprocessing = 'null'.obs;
  var isShopIntervalProcessing = 'null'.obs;
  var isJoining = 'null'.obs;
  var isShopTypeProcessing = 'null'.obs;
  var plansList = <Plan>[].obs;
  var disPlansList = <Plan>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  getPlans(pageNum, userId) async {
    var seeker = await ApiServices.getAllPlans(pageNum, userId);
    if (seeker != null) {
      isShoprocessing.value = 'yes';
      plansList.value = seeker.cast<Plan>();
    } else {
      isShoprocessing.value = 'no';
    }
  }

  getPlansMore(pageNum, userId) async {
    var seeker = await ApiServices.getAllPlans(pageNum, userId);
    if (seeker != null) {
      plansList.addAll(seeker.cast<Plan>());
    } else {}
  }

  getDisPlansInterval(pageNum, planInterval, userId) async {
    if (planInterval != 'land' || planInterval != 'building') {
      disPlansList.clear();
      isShopIntervalProcessing.value = 'null';
    }

    var seeker =
        await ApiServices.getDisPlansInterval(pageNum, planInterval, userId);
    if (seeker != null) {
      isShopIntervalProcessing.value = 'yes';
      disPlansList.value = seeker.cast<Plan>();
    } else {
      isShopIntervalProcessing.value = 'no';
    }
  }

  getDisPlansIntervalMore(pageNum, planInterval, userId) async {
    var seeker =
        await ApiServices.getDisPlansInterval(pageNum, planInterval, userId);
    if (seeker != null) {
      disPlansList.addAll(seeker.cast<Plan>());
    } else {}
  }

  getDisPlansType(pageNum, planInterval, userId) async {
    if (planInterval == 'land' || planInterval == 'building') {
      disPlansList.clear();
      isShopIntervalProcessing.value = 'null';
    }

    var seeker =
        await ApiServices.getDisPlansType(pageNum, planInterval, userId);
    if (seeker != null) {
      isShopIntervalProcessing.value = 'yes';
      disPlansList.value = seeker.cast<Plan>();
    } else {
      isShopIntervalProcessing.value = 'no';
    }
  }

  getDisPlansTypeMore(pageNum, planInterval, userId) async {
    var seeker =
        await ApiServices.getDisPlansType(pageNum, planInterval, userId);
    if (seeker != null) {
      disPlansList.addAll(seeker.cast<Plan>());
    } else {}
  }

  joinSub(userId, planId, planCode) async {
    isJoining.value = 'null';
    var status = await ApiServices.joinSubscription(userId, planId, planCode);
    if (userId == null) {
      showSnackBar(
        title: 'Oops!',
        msg: 'You need to Login before you can perform this action',
        backgroundColor: Colors.blue.shade900,
      );
      return false;
    }

    if (status) {
      isJoining.value = 'yes';
      return true;
    } else {
      isJoining.value = 'no';
      return false;
    }
  }
}
