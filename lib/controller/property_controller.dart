import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/common.dart';

import '../model/property_model.dart';
import '../model/types_property_model.dart';
import '../services/api_services.dart';
import '../widget/my_raidio_field.dart';

class PropertyController extends GetxController {
  PropertyController get getXID => Get.find<PropertyController>();

  var page_num = 1;
  var isHomeFetchProcessing = 'null'.obs;
  var isMyProductProcessing = 'null'.obs;
  var disProductProcessing = 'null'.obs;
  //
  var isAllProductProcessing = 'null'.obs;
  var isPendingProductProcessing = 'null'.obs;
  var isApprovedProductProcessing = 'null'.obs;
  var isRejectedProductProcessing = 'null'.obs;
  var isSearchDataProcessing = false.obs;

  //
  var isFavProcessing = 'null'.obs;
  var isSearchProcessing = 'null'.obs;
  var isLocationProcessing = 'null'.obs;
  var isPriceProcessing = 'null'.obs;
  var isTypeProcessing = 'null'.obs;

  var propertyList = <PropertyModel>[].obs;
  var allPropertyList = <PropertyModel>[].obs;
  var pendingPropertyList = <PropertyModel>[].obs;
  var approvedPropertyList = <PropertyModel>[].obs;
  var rejectedPropertyList = <PropertyModel>[].obs;
  var myPropertyList = <PropertyModel>[].obs;
  var disPropertyList = <PropertyModel>[].obs;
  var searchPropertyList = <PropertyModel>[].obs;
  var favPropertyList = <PropertyModel>[].obs;
  var typesPropertyList = <TypesPropertyModel>[].obs;
  var imageList = <GetAllPropsImage>[].obs;

  // String? user_id;
  // String? user_status;

  @override
  void onInit() async {
    super.onInit();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // user_id = prefs.getString('user_id');
    // user_status = prefs.getString('user_status');
    // await getDetails(user_id);
    await fetchTypesProps();

    // await fetch_favourite(page_num, user_id);
    // await getMyProduct(user_id);

    // await manageProduct(user_id, 'all');
    // await manageProduct(user_id, 'pending');
    // await manageProduct(user_id, 'approved');
    // await manageProduct(user_id, 'rejected');

    // fetchStateRegion();
  }

  getDetails(var userId) async {
    var seeker = await ApiServices.getAllProducts(page_num, userId);

    if (seeker != null) {
      isHomeFetchProcessing.value = 'yes';
      propertyList.value = seeker.cast<PropertyModel>();
    } else {
      isHomeFetchProcessing.value = 'no';
    }
  }

  void getMoreDetail(var pageNum, var userId) async {
    var seeker = await ApiServices.getAllProducts(pageNum, userId);

    if (seeker != null) {
      propertyList.addAll(seeker.cast<PropertyModel>());
    } else {}
  }

  Future<bool> toggleLike(var userId, var propsId, PropertyModel model,
      var route, user_status) async {
    //return await !status;
    String status = await ApiServices.toggleLike(userId, propsId);
    if (userId == null) {
      showSnackBar(
        title: 'Oops!',
        msg: 'You need to Login before you can perform this action',
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (user_status != 'user') {
      showSnackBar(
        title: 'Oops!',
        msg: 'This action is only for Users not Landlord or Agent',
        backgroundColor: Colors.red,
      );
      return false;
    }

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

    isSearchDataProcessing(true);
    if (seeker != null) {
      isSearchProcessing.value = 'yes';
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    } else {
      isSearchProcessing.value = 'no';
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
    } else {}
  }

  void filter_search_page_location(
      var pageNum, var stateId, var areaId, var userId) async {
    searchPropertyList.clear();
    var seeker = await ApiServices.getFilterProductLocation(
        pageNum, userId, stateId, areaId);

    if (seeker != null) {
      isLocationProcessing.value = 'yes';
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    } else {
      isLocationProcessing.value = 'no';
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
      isTypeProcessing.value = 'null';
      searchPropertyList.addAll(seeker.cast<PropertyModel>());
    } else {
      isTypeProcessing.value = 'null';
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

    isSearchDataProcessing(true);
    if (seeker != null) {
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

  fetch_favourite(var pageNum, var userId) async {
    isFavProcessing.value = 'null';
    favPropertyList.clear();

    var seeker = await ApiServices.getAllFav(pageNum, userId);
    if (seeker != null) {
      isFavProcessing.value = 'yes';
      favPropertyList.addAll(seeker.cast<PropertyModel>());
    } else {
      isFavProcessing.value = 'no';
    }
  }

  void fetch_more_favourite(var pageNum, var userId) async {
    var seeker = await ApiServices.getAllFav(pageNum, userId);

    if (seeker != null) {
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
    required String user_id,
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
      user_id: user_id,
    );

    bool statusType;
    String? msg;
    if (status == true) {
      msg = 'Product Created';
      statusType = true;
      showSnackBar(
          title: 'Create Product', msg: msg, backgroundColor: Colors.blue);
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = false;
      showSnackBar(
          title: 'Create Product', msg: msg, backgroundColor: Colors.red);
    }

    return statusType;
  }

  getMyProduct(var userId) async {
    // print('user id $userId');
    var seeker = await ApiServices.getMyProducts(page_num, userId);
    if (seeker != null) {
      isMyProductProcessing.value = 'yes';
      myPropertyList.value = seeker.cast<PropertyModel>();
    } else {
      isMyProductProcessing.value = 'no';
    }
  }

  void getMyProductMore(var pageNum, var userId) async {
    var seeker = await ApiServices.getMyProducts(pageNum, userId);

    if (seeker != null) {
      myPropertyList.addAll(seeker.cast<PropertyModel>());
    } else {}
  }

  getDisProduct(var prodId, user_id) async {
    var seeker = await ApiServices.getDisProduct(page_num, user_id, prodId);
    if (seeker != null) {
      disProductProcessing.value = 'yes';
      disPropertyList.value = seeker.cast<PropertyModel>();
    } else {
      disProductProcessing.value = 'no';
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
    required String user_id,
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
      user_id: user_id,
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
    required String user_id,
  }) async {
    bool status = await ApiServices.editExtraDetail(
      propsCondition: propsCondition,
      propsCautionFee: propsCautionFee,
      selectedPref: selectedPref,
      propsId: propsId,
      user_id: user_id,
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
    required String user_id,
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
      user_id: user_id,
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

  editFacilities({
    required String shopping,
    required String hospital,
    required String petrol,
    required String airport,
    required String church,
    required String mosque,
    required String school,
    required String propsId,
    required String user_id,
  }) async {
    // print('here');
    bool? status = await ApiServices.editFacilities(
      shopping: shopping,
      hospital: hospital,
      petrol: petrol,
      airport: airport,
      church: church,
      mosque: mosque,
      school: school,
      propsId: propsId,
      user_id: user_id,
    );

    bool statusType;
    String? msg;
    // print('this status $status');
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

  editValuation({
    required String crime,
    required String traffic,
    required String pollution,
    required String education,
    required String health,
    required String propsId,
    required String user_id,
  }) async {
    bool status = await ApiServices.editValuation(
      crime: crime,
      traffic: traffic,
      pollution: pollution,
      education: education,
      health: health,
      propsId: propsId,
      user_id: user_id,
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

  Future<bool> deleteProps(var userId, var propsId, var imageId) async {
    bool status = await ApiServices.deleteProps(userId, propsId, imageId);
    bool statusType;
    String? msg;

    if (status == true) {
      msg = 'Image Deleted from List';
      statusType = true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      statusType = false;
    }
    showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);

    return statusType;
  }

  uploadImage(var userId, var propsId, File imageName, var model) async {
    var status = await ApiServices.uploadImage(
        userId: userId, propsId: propsId, image: imageName);

    String? msg;

    if (status != false) {
      msg = 'Image Uploaded';
      showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);

      return status;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  uploadFeatureImage(var userId, var propsId, File imageName, var model) async {
    var status = await ApiServices.uploadFeatureImage(
        userId: userId, propsId: propsId, image: imageName);

    String? msg;

    if (status != false) {
      msg = 'Feature Image Uploaded';
      showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);

      return status;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Product', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> submitProperty(var propsId) async {
    bool status = await ApiServices.submitProperty(propsId);

    String? msg;
    if (status) {
      msg = 'Awaiting Admin to Review Property,\nthis may take awhile';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> deleteProperty(var propsId) async {
    bool status = await ApiServices.deleteProperty(propsId);

    String? msg;
    if (status) {
      msg = 'Property Removed From List';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  manageProduct(var userId, var type) async {
    var seeker = await ApiServices.manageProducts(page_num, userId, type);
    if (seeker != null) {
      if (type == 'all') {
        isAllProductProcessing.value = 'yes';
        allPropertyList.addAll(seeker.cast<PropertyModel>());
      } else if (type == 'pending') {
        isPendingProductProcessing.value = 'yes';
        pendingPropertyList.addAll(seeker.cast<PropertyModel>());
      } else if (type == 'approved') {
        isApprovedProductProcessing.value = 'yes';
        approvedPropertyList.addAll(seeker.cast<PropertyModel>());
      } else if (type == 'rejected') {
        isRejectedProductProcessing.value = 'yes';
        rejectedPropertyList.addAll(seeker.cast<PropertyModel>());
      }
    } else {
      if (type == 'all') {
        isAllProductProcessing.value = 'no';
      } else if (type == 'pending') {
        isPendingProductProcessing.value = 'no';
      } else if (type == 'approved') {
        isApprovedProductProcessing.value = 'no';
      } else if (type == 'rejected') {
        isRejectedProductProcessing.value = 'no';
      }
    }
  }

  manageProductMore(var pageNum, var userId, var type) async {
    var seeker = await ApiServices.manageProducts(pageNum, userId, type);

    if (seeker != null) {
      if (type == 'all') {
        allPropertyList.addAll(seeker.cast<PropertyModel>());
      } else if (type == 'pending') {
        pendingPropertyList.addAll(seeker.cast<PropertyModel>());
      } else if (type == 'approved') {
        approvedPropertyList.addAll(seeker.cast<PropertyModel>());
      } else if (type == 'rejected') {
        rejectedPropertyList.addAll(seeker.cast<PropertyModel>());
      }
    } else {}
  }

  Future<bool> approveProperty({
    required String propsId,
    required String userId,
    required String agentId,
  }) async {
    String? msg;
    bool status = await ApiServices.approveProperty(
        propsId: propsId, userId: userId, agentId: agentId);
    if (status) {
      msg =
          'Property status is now Approved and Visible to all users and quest';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> rejectProperty({
    required String propsId,
    required String userId,
    required String agentId,
    required String message,
  }) async {
    String? msg;
    bool status = await ApiServices.rejectProperty(
        propsId: propsId, userId: userId, agentId: agentId, message: message);
    if (status) {
      msg =
          'Property Live Status is now updated to Rejected, no site user or quest can see it except only the uploader';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> reportProperty({
    required String propsId,
    required String userId,
    required String type,
  }) async {
    String? msg;
    String status = await ApiServices.reportProperty(
      propsId: propsId,
      userId: userId,
      type: type,
    );
    if (status == 'true') {
      msg = 'Report has been submitted, awaiting admin';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else if (status == 'false') {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return false;
    } else {
      msg =
          'You have already report this property, please be patient why the admin act on this';
      showSnackBar(title: 'Property', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }
}
