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
  var myPropertyList = <PropertyModel>[].obs;
  var disPropertyList = <PropertyModel>[].obs;
  var searchPropertyList = <PropertyModel>[].obs;
  var favPropertyList = <PropertyModel>[].obs;
  var typesPropertyList = <TypesPropertyModel>[].obs;

  String? user_id;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    await getDetails(user_id);
    await fetchTypesProps();

    fetch_favourite(page_num, user_id);
    getMyProduct(user_id);

    // fetchStateRegion();
  }

  getDetails(var userId) async {
    var seeker = await ApiServices.getAllProducts(page_num, userId);
    if (seeker != null) {
      isDataProcessing(true);
      propertyList.value = seeker.cast<PropertyModel>();
    } else {
      isDataProcessing(false);
    }
  }

  void getMoreDetail(var pageNum, var userId) async {
    var seeker = await ApiServices.getAllProducts(pageNum, userId);

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
        favPropertyList[index].favourite = true;
      } else if (route == 'dashboard') {
        int index = disPropertyList.indexOf(model);
        disPropertyList[index].favourite = true;
      }

      propertyList.refresh();
      searchPropertyList.refresh();
      favPropertyList.refresh();
      disPropertyList.refresh();

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
        favPropertyList[index].favourite = false;
      } else if (route == 'dashboard') {
        int index = disPropertyList.indexOf(model);
        disPropertyList[index].favourite = false;
      }
      propertyList.refresh();
      searchPropertyList.refresh();
      favPropertyList.refresh();
      myPropertyList.refresh();

      return false;
    }
    return false;
  }

  Future<void> requestInspection(var userId, var propsId, var agentId) async {
    String status =
        await ApiServices.requestInspection(userId, propsId, agentId);
    showSnackBar(title: 'Request', msg: status, backgroundColor: Colors.blue);
  }

  void fetch_search_page(var pageNum, var searchTerm, var userId) async {
    searchPropertyList.clear();
    var seeker =
        await ApiServices.getSearchProduct(pageNum, userId, searchTerm);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void fetch_search_page_by_pagination(
      var pageNum, var searchTerm, var userId) async {
    var seeker =
        await ApiServices.getSearchProduct(pageNum, userId, searchTerm);

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
      var pageNum, var stateId, var areaId, var userId) async {
    searchPropertyList.clear();
    var seeker = await ApiServices.getFilterProductLocation(
        pageNum, userId, stateId, areaId);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_location_by_pagination(
      var pageNum, var stateId, var areaId, var userId) async {
    var seeker = await ApiServices.getFilterProductLocation(
        pageNum, userId, stateId, areaId);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_type(var pageNum, var typeId, var userId) async {
    searchPropertyList.clear();
    var seeker =
        await ApiServices.getFilterProductType(pageNum, userId, typeId);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_type_by_pagination(
      var pageNum, var typeId, var userId) async {
    var seeker =
        await ApiServices.getFilterProductType(pageNum, userId, typeId);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_price(
      var pageNum, var startPrice, endPrice, var userId) async {
    searchPropertyList.clear();
    var seeker = await ApiServices.getFilterProductPrice(
        pageNum, userId, startPrice, endPrice);

    if (seeker != null) {
      isSearchDataProcessing(true);
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void filter_search_page_price_by_pagination(
      var pageNum, var startPrice, endPrice, var userId) async {
    var seeker = await ApiServices.getFilterProductPrice(
        pageNum, userId, startPrice, endPrice);

    if (seeker != null) {
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void fetch_favourite(var pageNum, var userId) async {
    favPropertyList.clear();
    var seeker = await ApiServices.getAllFav(pageNum, userId);

    if (seeker != null) {
      isSearchDataProcessing(true);
      favPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  void fetch_more_favourite(var pageNum, var userId) async {
    var seeker = await ApiServices.getAllFav(pageNum, userId);

    if (seeker != null) {
      isSearchDataProcessing(true);
      favPropertyList.addAll(seeker.cast<PropertyModel>());
    }
  }

  addProduct({
    required String propsName,
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
    required File image,
    //
    required String shopping,
    required String hospital,
    required String petrol,
    required String airport,
    required String church,
    required String mosque,
    required String school,
    //
    required String crime,
    required String traffic,
    required String pollution,
    required String education,
    required String health,
  }) async {
    bool status = await ApiServices.addProduct(
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
      image: image,
      //
      shopping: shopping,
      hospital: hospital,
      petrol: petrol,
      airport: airport,
      church: church,
      mosque: mosque,
      school: school,
      //
      crime: crime,
      traffic: traffic,
      pollution: pollution,
      education: education,
      health: health,
      user_id: user_id!,
    );

    bool statusType;
    String? msg;
    if (status == true) {
      msg = 'Product Created';
      statusType = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = false;
    }
    showSnackBar(
        title: 'Create Product', msg: msg, backgroundColor: Colors.blue);

    return statusType;
  }

  getMyProduct(var userId) async {
    var seeker = await ApiServices.getMyProducts(page_num, userId);
    if (seeker != null) {
      isDataProcessing(true);
      myPropertyList.value = seeker.cast<PropertyModel>();
    } else {
      isDataProcessing(false);
    }
  }

  void getMyProductMore(var pageNum, var userId) async {
    var seeker = await ApiServices.getMyProducts(pageNum, userId);

    if (seeker != null) {
      isMoreDataAvailable(true);
      myPropertyList.addAll(seeker.cast<PropertyModel>());
      // propertyList.refresh();
      isMoreDataAvailable(false);
    } else {
      isMoreDataAvailable(false);
    }
  }

  getDisProduct(var prodId) async {
    var seeker = await ApiServices.getDisProduct(page_num, user_id, prodId);
    if (seeker != null) {
      isDataProcessing(true);
      disPropertyList.value = seeker.cast<PropertyModel>();
    } else {
      isDataProcessing(false);
    }
  }

  editBasicDetail({
    required String propsName,
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
    required String propsId,
    required PropertyModel model,
  }) async {
    bool status = await ApiServices.editBasicDetail(
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
      propsId: propsId,
      user_id: user_id!,
    );

    bool statusType;
    String? msg;
    if (status == true) {
      msg =
          'Product Information Updated..., Changes will take effect in the next few min.';
      statusType = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = false;
    }
    showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);

    return statusType;
  }

  editExtraDetail({
    required String propsCondition,
    required String propsCautionFee,
    required String selectedPref,
    required String propsId,
  }) async {
    bool status = await ApiServices.editExtraDetail(
      propsCondition: propsCondition,
      propsCautionFee: propsCautionFee,
      selectedPref: selectedPref,
      propsId: propsId,
      user_id: user_id!,
    );

    bool statusType;
    String? msg;
    if (status == true) {
      msg =
          'Product Information Updated..., Changes will take effect in the next few min.';
      statusType = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = false;
    }
    showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);

    return statusType;
  }

  editAmenities({
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
    required String propsId,
  }) async {
    bool status = await ApiServices.editAmenties(
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
      propsId: propsId,
      user_id: user_id!,
    );

    bool statusType;
    String? msg;
    if (status == true) {
      msg = 'Product Created';
      statusType = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = false;
    }
    showSnackBar(
        title: 'Create Product', msg: msg, backgroundColor: Colors.blue);

    return statusType;
  }
}
