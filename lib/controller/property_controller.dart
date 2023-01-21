import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  var searchPropertyList = <PropertyModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
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
      // propertyList.refresh();
      isMoreDataAvailable(false);
    } else {
      isMoreDataAvailable(false);
    }
  }

  Future<bool> toggleLike(
      var userId, var propsId, PropertyModel model, var route) async {
    //return await !status;
    String status = await ApiServices.toggleLike(userId, propsId);

    if (status == 'liked') {
      if (route == 'default') {
        int index = propertyList.indexOf(model);
        propertyList[index].favourite = true;
      } else if (route == 'search') {
        int index = searchPropertyList.indexOf(model);
        searchPropertyList[index].favourite = true;
      }

      propertyList.refresh();
      searchPropertyList.refresh();

      return true;
    } else if (status == 'unliked') {
      if (route == 'default') {
        int index = propertyList.indexOf(model);
        propertyList[index].favourite = false;
      } else if (route == 'search') {
        int index = searchPropertyList.indexOf(model);
        searchPropertyList[index].favourite = false;
      }
      propertyList.refresh();
      searchPropertyList.refresh();

      return false;
    }
    return false;
  }

  Future<void> requestInspection(var userId, var propsId, var agent_id) async {
    String status =
        await ApiServices.requestInspection(userId, propsId, agent_id);
    showSnackBar(title: 'Request', msg: status, backgroundColor: Colors.blue);
  }

  void fetch_search_page(var page_num, var search_term, var user_id) async {
    searchPropertyList.clear();
    var seeker =
        await ApiServices.getSearchProduct(page_num, user_id, search_term);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void fetch_search_page_by_pagination(
      var page_num, var search_term, var user_id) async {
    var seeker =
        await ApiServices.getSearchProduct(page_num, user_id, search_term);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }
}
