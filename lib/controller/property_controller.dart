import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/common.dart';

import '../model/property_model.dart';
import '../services/api_services.dart';

class PropertyController extends GetxController {
  PropertyController get getXID => Get.find<PropertyController>();

  var page_num = 1;
  var isWidgetLoading = true.obs;
  var isDataProcessing = false.obs;
  var isSearchDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var propertyList = <PropertyModel>[].obs;
  var user_id = 1;

  @override
  void onInit() async {
    super.onInit();
    await getDetails(user_id);
  }

  getDetails(var user_id) async {
    var seeker = await ApiServices.getAllProducts(page_num, user_id);
    if (seeker != null) {
      isDataProcessing(true);
      propertyList.value = seeker.cast<PropertyModel>();
    } else {
      isDataProcessing(false);
    }
  }

  void getMoreDetail(var page_num, var user_id) async {
    var seeker = await ApiServices.getAllProducts(page_num, user_id);

    if (seeker != null) {
      isMoreDataAvailable(true);
      propertyList.addAll(seeker.cast<PropertyModel>());
      isMoreDataAvailable(false);
    } else {
      isMoreDataAvailable(false);
    }
  }

  Future<bool> toggleLike(var userId, var propsId, PropertyModel model) async {
    //return await !status;
    String status = await ApiServices.toggleLike(userId, propsId);

    if (status == 'liked') {
      int index = propertyList.indexOf(model);

      propertyList[index].favourite = true;

      return true;
    } else if (status == 'unliked') {
      int index = propertyList.indexOf(model);
      propertyList[index].favourite = false;

      return false;
    }
    return false;
  }

  Future<void> requestInspection(var userId, var propsId, var agent_id) async {
    String status =
        await ApiServices.requestInspection(userId, propsId, agent_id);
    showSnackBar(title: 'Request', msg: status, backgroundColor: Colors.blue);
  }
}
