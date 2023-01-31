import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/property_model.dart';
import '../model/types_property_model.dart';
import '../services/api_services.dart';
import '../widget/my_raidio_field.dart';

class PropertyController extends GetxController {
  PropertyController get getXID => Get.find<PropertyController>();

  var page_num = 1;
  var isWidgetLoading = true.obs;
  var isDataProcessing = false.obs;
  var isSearchDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;

  var propertyList = <PropertyModel>[].obs;
  var searchPropertyList = <PropertyModel>[].obs;
  var favPropertyList = <PropertyModel>[].obs;
  var typesPropertyList = <TypesPropertyModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    await getDetails(user_id);
    await fetchTypesProps();

    fetch_favourite(page_num, user_id);

    // fetchStateRegion();
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
      } else if (route == 'fav') {
        int index = favPropertyList.indexOf(model);
        favPropertyList[index].favourite = false;
      }

      propertyList.refresh();
      searchPropertyList.refresh();
      favPropertyList.refresh();

      return true;
    } else if (status == 'unliked') {
      if (route == 'default') {
        int index = propertyList.indexOf(model);
        propertyList[index].favourite = false;
      } else if (route == 'search') {
        int index = searchPropertyList.indexOf(model);
        searchPropertyList[index].favourite = false;
      } else if (route == 'fav') {
        int index = favPropertyList.indexOf(model);
        favPropertyList[index].favourite = true;
      }
      propertyList.refresh();
      searchPropertyList.refresh();
      favPropertyList.refresh();

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

  fetchTypesProps() async {
    var seeker = await ApiServices.getTypesProperty();
    if (seeker != null) {
      typesPropertyList.value = seeker.cast<TypesPropertyModel>();
    } else {
      isDataProcessing(false);
    }
  }

  void filter_search_page_location(
      var page_num, var state_id, var area_id, var user_id) async {
    searchPropertyList.clear();
    var seeker = await ApiServices.getFilterProductLocation(
        page_num, user_id, state_id, area_id);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_location_by_pagination(
      var page_num, var state_id, var area_id, var user_id) async {
    var seeker = await ApiServices.getFilterProductLocation(
        page_num, user_id, state_id, area_id);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_type(var page_num, var type_id, var user_id) async {
    searchPropertyList.clear();
    var seeker =
        await ApiServices.getFilterProductType(page_num, user_id, type_id);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_type_by_pagination(
      var page_num, var type_id, var user_id) async {
    var seeker =
        await ApiServices.getFilterProductType(page_num, user_id, type_id);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_price(
      var page_num, var start_price, end_price, var user_id) async {
    searchPropertyList.clear();
    var seeker = await ApiServices.getFilterProductPrice(
        page_num, user_id, start_price, end_price);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_price_by_pagination(
      var page_num, var start_price, end_price, var user_id) async {
    var seeker = await ApiServices.getFilterProductPrice(
        page_num, user_id, start_price, end_price);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void fetch_favourite(var page_num, var user_id) async {
    favPropertyList.clear();
    var seeker = await ApiServices.getAllFav(page_num, user_id);

    if (seeker != null) {
      isSearchDataProcessing(true);
      favPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void fetch_more_favourite(var page_num, var user_id) async {
    var seeker = await ApiServices.getAllFav(page_num, user_id);

    if (seeker != null) {
      isSearchDataProcessing(true);
      favPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  addProduct(
      {required String propsName,
      required String props_purpose,
      required String props_type,
      required String sub_props_type,
      required String propsBed,
      required String propsBath,
      required String propsToilet,
      required String state_id,
      required String area_id,
      required String propsPrice,
      required String propsDesc,
      required String propsYearBuilt,
      required propertyModeEnum props_mode,
      required String propsYoutubeId,
      required bool air_condition,
      required bool balcony,
      required bool bedding,
      required bool cable_tv,
      required bool cleaning_after_exist,
      required bool coffee_pot,
      required bool computer,
      required bool cot,
      required bool dishwasher,
      required bool dvd,
      required bool fan,
      required bool fridge,
      required bool grill,
      required bool hairdryer,
      required bool heater,
      required bool hi_fi,
      required bool internet,
      required bool iron,
      required bool juicer,
      required bool lift,
      required bool microwave,
      required bool gym,
      required bool fireplace,
      required bool hot_tub,
      required String propsCondition,
      required String propsCautionFee,
      required String selectedPref,
      required File image}) async {
    String status = await ApiServices.addProduct(
        propsName: propsName,
        props_purpose: props_purpose,
        props_type: props_type,
        sub_props_type: sub_props_type,
        propsBed: propsBed,
        propsBath: propsBath,
        propsToilet: propsToilet,
        state_id: state_id,
        area_id: area_id,
        propsPrice: propsPrice,
        propsDesc: propsDesc,
        propsYearBuilt: propsYearBuilt,
        props_mode: props_mode,
        propsYoutubeId: propsYoutubeId,
        air_condition: air_condition,
        balcony: balcony,
        bedding: bedding,
        cable_tv: cable_tv,
        cleaning_after_exist: cleaning_after_exist,
        coffee_pot: coffee_pot,
        computer: computer,
        cot: cot,
        dishwasher: dishwasher,
        dvd: dvd,
        fan: fan,
        fridge: fridge,
        grill: grill,
        hairdryer: hairdryer,
        heater: heater,
        hi_fi: hi_fi,
        internet: internet,
        iron: iron,
        juicer: juicer,
        lift: lift,
        microwave: microwave,
        gym: gym,
        fireplace: fireplace,
        hot_tub: hot_tub,
        propsCondition: propsCondition,
        propsCautionFee: propsCautionFee,
        selectedPref: selectedPref,
        image: image);

    bool status_type;
    String? msg;
    if (status == 'true') {
      msg = 'Request Marked';
      status_type = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      status_type = true;
    }
    showSnackBar(title: 'Make Request', msg: msg, backgroundColor: Colors.blue);

    return status_type;
  }
}
