import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oga_bliss/util/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/users_model.dart';
import '../services/api_services.dart';

class UsersController extends GetxController {
  UsersController get getXID => Get.find<UsersController>();

  var page_num = 1;
  var isDataProcessing = false.obs;
  var isMoreDataAvailable = true.obs;
  var isUserFetching = false.obs;
  var usersList = <UsersModel>[].obs;
  var disUsersList = <UsersModel>[].obs;
  var landLordList = <UsersModel>[].obs;

  String? user_id;
  bool? admin_status;
  String? user_status;

  @override
  void onInit() async {
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    admin_status = prefs.getBool('admin_status');
    user_status = prefs.getString('user_status');
    await getUsers(page_num);
    await getLandlord(page_num);
  }

  getUsers(pageNum) async {
    var seeker = await ApiServices.getUsers(pageNum);
    if (seeker != null) {
      isDataProcessing(true);
      usersList.value = seeker.cast<UsersModel>();
    } else {
      isDataProcessing(false);
    }
  }

  getUsersMore(pageNum) async {
    var seeker = await ApiServices.getUsers(pageNum);
    if (seeker != null) {
      isDataProcessing(true);
      usersList.addAll(seeker.cast<UsersModel>());
    } else {
      isDataProcessing(false);
    }
  }

  getLandlord(pageNum) async {
    var seeker = await ApiServices.getLandlords(pageNum);
    if (seeker != null) {
      isDataProcessing(true);
      landLordList.value = seeker.cast<UsersModel>();
    } else {
      isDataProcessing(false);
    }
  }

  getLandLordsMore(pageNum) async {
    var seeker = await ApiServices.getLandlords(pageNum);
    if (seeker != null) {
      isDataProcessing(true);
      landLordList.addAll(seeker.cast<UsersModel>());
    } else {
      isDataProcessing(false);
    }
  }

  Future<String> toggleBan({
    required String userId,
  }) async {
    String? msg;
    String status = await ApiServices.toggleBan(UserId: userId);
    if (status == 'ban') {
      msg = 'User Added to Ban List';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return 'ban';
    } else if (status == 'unban') {
      msg = 'User Removed from Ban List';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return 'unban';
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return 'false';
    }
  }

  Future<bool> deleteUser({
    required String userId,
  }) async {
    String? msg;
    bool status = await ApiServices.deleteUser(UserId: userId);
    if (status) {
      msg = 'User Removed from Database';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Database Busy, Could not perform operation, Pls Try Again Later!';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> sendEmail({
    required String disUserId,
    required String fullName,
    required String email,
    required String subject,
    required String message,
  }) async {
    String? msg;
    bool status = await ApiServices.sendEmail(
        disUserId: disUserId,
        fullName: fullName,
        email: email,
        subject: subject,
        message: message);
    if (status) {
      msg = 'Email Sent...';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Email having trouble delivering';
      showSnackBar(
          title: 'User Management', msg: msg, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> signUp({
    required String userName,
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String usersType,
  }) async {
    String? msg;
    String status = await ApiServices.signUp(
      userName: userName,
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      userType: usersType,
    );
    if (status == 'true') {
      msg = 'Account Creation was successful...';
      showSnackBar(
          title: 'Account Creation', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = '';
      showSnackBar(
          title: 'Account Creation', msg: status, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    String? msg;
    String status = await ApiServices.login(
      email: email,
      password: password,
    );
    if (status == 'true') {
      msg = 'Login Successful...';
      showSnackBar(title: 'Success', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = '';
      showSnackBar(title: 'Oops', msg: status, backgroundColor: Colors.blue);
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
  }) async {
    String? msg;
    String status = await ApiServices.resetPassword(
      email: email,
    );
    if (status == 'true') {
      msg =
          'An Email has been Sent to the provided email for further instruction!...';
      showSnackBar(
          title: 'Congratulation', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = '';
      showSnackBar(title: 'Oops', msg: status, backgroundColor: Colors.blue);
      return false;
    }
  }

  getDisUser(var userId) async {
    disUsersList.clear();
    isUserFetching(true);
    var seeker = await ApiServices.getDisUser(userId);
    if (seeker != null) {
      isUserFetching(false);
      disUsersList.value = seeker.cast<UsersModel>();
    } else {
      isUserFetching(false);
    }
  }

  Future<bool> updateUserBio({
    required String fullName,
    required String email,
    required String phone,
    required String age,
    required String address,
    required String sex,
    required String my_id,
  }) async {
    String? msg;
    String status = await ApiServices.updateUserBio(
      fullName: fullName,
      email: email,
      phone: phone,
      age: age,
      address: address,
      sex: sex,
      my_id: my_id,
    ); 
    if (status == 'true') {
      msg = 'Update Successful...';
      showSnackBar(title: 'Success', msg: msg, backgroundColor: Colors.blue);
      return true;
    } else {
      msg = 'Could not update Profile';
      showSnackBar(title: 'Oops', msg: msg, backgroundColor: Colors.blue);
      return false;  
    }
  }
}
