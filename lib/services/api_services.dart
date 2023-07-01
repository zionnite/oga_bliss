import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oga_bliss/bliss_legacy/bliss_model/account_report.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/card_activities.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/count_subscription_item.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/join_subscription.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/my_point_item.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/point_items.dart';
import 'package:oga_bliss/bliss_legacy/bliss_model/subscription_list_model.dart';
import 'package:oga_bliss/controller/property_doc.dart';
import 'package:oga_bliss/model/banklist_model.dart';
import 'package:oga_bliss/model/dashboard_model.dart';
import 'package:oga_bliss/model/link_activity_model.dart';
import 'package:oga_bliss/model/marketing_model.dart';
import 'package:oga_bliss/model/property_purchase.dart';
import 'package:oga_bliss/model/property_type_model.dart';
import 'package:oga_bliss/model/withdrawal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bliss_legacy/bliss_model/bliss_downline_model.dart';
import '../bliss_legacy/bliss_model/bliss_transaction_model.dart';
import '../bliss_legacy/bliss_model/subscription_plan_model.dart';
import '../model/alert_model.dart';
import '../model/chat_head_model.dart';
import '../model/connection_model.dart';
import '../model/property_model.dart';
import '../model/request_model.dart';
import '../model/state_model.dart';
import '../model/transaction_model.dart';
import '../model/types_property_model.dart';
import '../model/users_model.dart';
import '../model/wallet_model.dart';
import '../util/common.dart';
import '../widget/my_raidio_field.dart';

class ApiServices {
  static var client = http.Client();
  static const String _mybaseUrl = baseUrl;
  static const String _mybaseUrlSec = baseUrlSec;

  /***
   * below relife start
   */
  // static const String _mybaseUrl = baseUrl;
  // static const String _mybaseUrlSec = baseUrlSec;

  static const String _all_product = 'get_all_product';
  static const String _toggle_product = 'toggle_product';
  static const String _request_inspection = 'request_inspection';
  static const String _make_inspection_request = 'make_inspection_request';
  static const String _make_request_specification =
      'make_request_specification';
  static const String _search_product = 'search_product';
  static const String _get_state = 'get_state_and_area';
  static const String _type_property = 'get_types_property';
  static const String _filter_location = 'filter_location';
  static const String _filter_type = 'filter_type';
  static const String _filter_price = 'filter_price';
  static const String _get_favourite = 'get_favourite';
  static const String _get_requeest = 'get_request';
  static const String _make_request = 'make_request';
  static const String _set_request_status = 'set_request_type';
  static const String _get_connection = 'get_connection';
  static const String _get_transaction = 'get_transaction';
  static const String _get_alert = 'get_alert';
  static const String _delete_alert = 'delete_alert';
  static const String _get_chat_head = 'get_message_head';
  static const String _get_wallet = 'get_wallet';
  static const String _pull_out = 'pull_out_payment';
  static const String _props_and_sub = 'get_props_type_and_sub_type';
  static const String _add_product = 'add_product';
  static const String _upload_title_document = 'upload_title_document';
  static const String _my_product = 'get_my_product';
  static const String _dis_product = 'get_dis_product';
  static const String _edit_basic = 'edit_basic';
  static const String _edit_extra = 'edit_extra_detail';
  static const String _edit_amenities = 'edit_amenities';
  static const String _edit_facilities = 'edit_facilities';
  static const String _edit_valuation = 'edit_valuation';
  static const String _edit_ownership = 'edit_ownership';
  static const String _delete_props = 'delete_props';
  static const String _delete_doc_file = 'delete_doc_file';
  static const String _update_image = 'update_image';
  static const String _update_feature_image = 'update_feature_image';
  static const String _submit_property = 'submit_property';
  static const String _delete_property = 'delete_property';
  static const String _manage_property = 'manage_product';
  static const String _approve_property = 'approve_property';
  static const String _reject_property = 'reject_property';
  static const String _get_users = 'get_users';
  static const String _get_landlords = 'get_landlords';
  static const String _toggle_ban = 'toggle_ban';
  static const String _delete_user = 'delete_user';
  static const String _message_user = 'message_user';
  static const String _signup = 'signup_authorization';
  static const String _login = 'login_authorization';
  static const String _resetPassword = 'reset_password';
  static const String _reportProperty = 'report_property';
  static const String _get_dis_user = 'get_dis_user';
  static const String _update_profile = 'update_profile';
  static const String _update_bank_detail = 'update_bank_detail';
  static const String _get_bank_list = 'get_bank_list';
  static const String _update_profile_image = 'update_profile_image';
  static const String _verify_bank_account = 'verify_bank_account';
  static const String _count_dashboard = 'count_dashboard';
  static const String _count_alert = 'count_alert';
  static const String _count_msg = 'count_msg';
  static const String _checkIfBan = 'check_ifBan';
  static const String _deleteAccount = 'delete_account';
  static String _has_new_update = 'has_new_update';
  static String _ios_store_link = 'ios_store_link';
  static String _android_store_link = 'android_store_link';

  static const String _getTop20Transaction = 'getTop20Transaction';
  static const String _getAccountReport = 'getAccountReport';
  static const String _get_direct_downline = 'get_direct_downline';
  static const String _get_all_plans = 'get_all_plans';
  static const String _get_all_plan_interval = 'get_all_plan_interval';
  static const String _get_all_plan_type = 'get_all_plan_type';
  static const String _get_my_subscription_list = 'get_my_subscription_list';
  static const String _get_my_subscription = 'get_my_subscription';
  static const String _get_subscription_counting = 'get_subscription_counting';
  static const String _toggle_disable_button = 'toggle_disable_button';
  static const String _send_request_to_email = 'send_request_to_email';
  static const String _join_sub = 'join_sub';
  static const String _get_all_point_items = 'get_all_point_items';
  static const String _get_my_point_items = 'get_my_point_items';
  static const String _all_purchase_product = 'get_all_purchase_product';
  static const String _get_doc_file = 'get_doc_file';
  static const String _get_referal = 'get_my_referal';
  static const String _get_withdrawal = 'get_withdrawal';
  static const String _request_withdrawal = 'request_withdrawal';
  static const String _approve_withdrawal = 'approve_withdrawal';
  static const String _reject_withdrawal = 'reject_withdrawal';
  static const String _promote_product = 'promote_product';
  static const String _copy_product_link = 'copy_product_link';
  static const String _get_product_promoting = 'get_product_promoting';
  static const String _get_link_activity = 'get_link_activity';

  static Future getAllProducts(var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_all_product/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        // final data = propertyModelFromJson(result.body);
        // retur data;
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> toggleLike(var userId, var propsId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_toggle_product');

      var response = await http.post(uri, body: {
        'user_id': userId.toString(),
        'props_id': propsId.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;
        // print('body $body');

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> requestInspection(
      var userId, var propsId, var agentId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_request_inspection');

      var response = await http.post(uri, body: {
        'user_id': userId,
        'props_id': propsId,
        'agent_id': agentId,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static getSearchProduct(var page_num, var userId, var search_term) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_search_product/$page_num/$userId');

      var response = await http.post(uri, body: {
        'search_term': search_term,
      });

      if (response.statusCode == 200) {
        // final data = propertyModelFromJson(response.body);
        // return data;

        var body = response.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static getStateRegion() async {
    try {
      final result = await client.get(Uri.parse('$_mybaseUrl$_get_state'));
      if (result.statusCode == 200) {
        LocationModel data = locationModelFromJson(result.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<TypesPropertyModel>> getTypesProperty() async {
    try {
      final result = await client.get(Uri.parse('$_mybaseUrl$_type_property'));
      if (result.statusCode == 200) {
        final data = typesPropertyModelFromJson(result.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static getFilterProductLocation(
      var page_num, var userId, var stateId, var areaId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_filter_location/$page_num/$userId');

      var response = await http.post(uri, body: {
        'state_id': stateId,
        'area_id': areaId,
      });

      if (response.statusCode == 200) {
        var body = response.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static getFilterProductType(var page_num, var userId, var typeId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_filter_type/$page_num/$userId');

      var response = await http.post(uri, body: {
        'type_id': typeId,
      });

      if (response.statusCode == 200) {
        // final data = propertyModelFromJson(response.body);
        // return data;

        var body = response.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static getFilterProductPrice(
      var page_num, var userId, var start_price, var end_price) async {
    print('start price ${start_price}');
    print('end price ${end_price}');

    try {
      final uri = Uri.parse('$_mybaseUrl$_filter_price/$page_num/$userId');

      var response = await http.post(uri, body: {
        'start_price': start_price,
        'end_price': end_price,
      });

      if (response.statusCode == 200) {
        // final data = propertyModelFromJson(response.body);
        // return data;

        var body = response.body;
        print(body);
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<List<PropertyModel?>?> getAllFav(
      var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_get_favourite/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        // final data = propertyModelFromJson(result.body);
        // return data;

        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<List<RequestModel?>?> getRequest(
      var pageNum, var userId, var adminStatus) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_requeest/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'admin_status': adminStatus.toString(),
      });

      if (response.statusCode == 200) {
        // final data = requestModelFromJson(response.body);
        // return data;

        var body = response.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['request'] as List;

          final data = disData
              .map<RequestModel>((json) => RequestModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> makeRequest(
      {required String id, required String usersType}) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_make_request');

      var response = await http.post(uri, body: {
        'id': id,
        'users_type': usersType,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> setRequestSetup({
    required String id,
    required String statusType,
    required String disUserId,
    required String agentId,
    required String propsId,
    required String user_id,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_set_request_status');

      var response = await http.post(uri, body: {
        'id': id,
        'status_type': statusType,
        'dis_user_id': disUserId,
        'agent_id': agentId,
        'props_id': propsId,
        'user_id': user_id,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<ConnectionModel?>?> getConnection(
      var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_get_connection/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        // final data = connectionModelFromJson(result.body);
        // return data;

        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['connection'] as List;

          final data = disData
              .map<ConnectionModel>((json) => ConnectionModel.fromJson(json))
              .toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
    }
  }

  static Future getTransaction(var pageNum, var userId, var adminStatus) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_transaction/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'admin_status': adminStatus.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['property_transaction'] as List;

          final data = disData
              .map<PropertyTransaction>(
                  (json) => PropertyTransaction.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {}
  }

  static Future<List<AlertModel?>?> getAlerts(var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_get_alert/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['alert'] as List;

          final data = disData
              .map<AlertModel>((json) => AlertModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> deleteAlert({required String id}) async {
    // print('hello $id');
    try {
      final uri = Uri.parse('$_mybaseUrl$_delete_alert');

      var response = await http.post(uri, body: {
        'id': id,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        // print(status);
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<ChatHeadModel?>?> getChatHead(
      var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_get_chat_head/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['heads'] as List;

          final data = disData
              .map<ChatHeadModel>((json) => ChatHeadModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<List<WalletModel?>?> getWallet(
      var pageNum, var userId, var userStatus) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_wallet/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'user_status': userStatus.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['wallet'] as List;

          final data = disData
              .map<WalletModel>((json) => WalletModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> pullOut({
    required String propsId,
    required String agentId,
    required String userId,
  }) async {
    try {
      final response = await client
          .get(Uri.parse('$_mybaseUrl$_pull_out/$propsId/$agentId/$userId'));

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static getPropertyAndSubTypes() async {
    try {
      final result = await client.get(Uri.parse('$_mybaseUrl$_props_and_sub'));
      if (result.statusCode == 200) {
        PropertyAndSubTypesModel data =
            propertyAndSubTypesModelFromJson(result.body);

        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> addProduct({
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

    //
    required String docName,
    required PlatformFile docFile,
    required String ownerStatus,
    required String ownerName,
    required String ownerPhone,
    required String ownerEmail,
    required String slightNegotiate,
    required String user_id,
  }) async {
    String? newMode;
    if (props_mode == 'propertyModeEnum.New') {
      newMode = 'New';
    } else if (props_mode == 'propertyModeEnum.Furnished') {
      newMode = 'Furnished';
    } else {
      newMode = 'Serviced';
    }

    try {
      final uri = Uri.parse('$_mybaseUrl$_add_product/$user_id');
      var request = http.MultipartRequest('POST', uri);
      request.fields['propsName'] = propsName;
      request.fields['props_purpose'] = props_purpose;
      request.fields['props_type'] = props_type;
      request.fields['sub_props_type'] = sub_props_type;
      request.fields['propsBed'] = propsBed;
      request.fields['propsBath'] = propsBath;
      request.fields['propsToilet'] = propsToilet;
      request.fields['state_id'] = state_id;
      request.fields['area_id'] = area_id;
      request.fields['propsPrice'] = propsPrice;
      request.fields['propsDesc'] = propsDesc;
      request.fields['propsYearBuilt'] = propsYearBuilt;
      request.fields['props_mode'] = newMode;
      request.fields['propsYoutubeId'] = propsYoutubeId;
      request.fields['air_condition'] = air_condition.toString();
      request.fields['balcony'] = balcony.toString();
      request.fields['bedding'] = bedding.toString();
      request.fields['cable_tv'] = cable_tv.toString();
      request.fields['cleaning_after_exist'] = cleaning_after_exist.toString();
      request.fields['coffee_pot'] = coffee_pot.toString();
      request.fields['computer'] = computer.toString();
      request.fields['cot'] = cot.toString();
      request.fields['dishwasher'] = dishwasher.toString();
      request.fields['dvd'] = dvd.toString();
      request.fields['fan'] = fan.toString();
      request.fields['fridge'] = fridge.toString();
      request.fields['grill'] = grill.toString();
      request.fields['hairdryer'] = hairdryer.toString();
      request.fields['heater'] = heater.toString();
      request.fields['hi_fi'] = hi_fi.toString();
      request.fields['internet'] = internet.toString();
      request.fields['iron'] = iron.toString();
      request.fields['juicer'] = juicer.toString();
      request.fields['lift'] = lift.toString();
      request.fields['microwave'] = microwave.toString();
      request.fields['gym'] = gym.toString();
      request.fields['fireplace'] = fireplace.toString();
      request.fields['hot_tub'] = hot_tub.toString();
      request.fields['propsCondition'] = propsCondition;
      request.fields['propsCautionFee'] = propsCautionFee;
      request.fields['selectedPref'] = selectedPref;
      //
      request.fields['shopping_mall'] = shopping.toString();
      request.fields['hospital'] = hospital.toString();
      request.fields['petrol_pump'] = petrol.toString();
      request.fields['airport'] = airport.toString();
      request.fields['church'] = church.toString();
      request.fields['mosque'] = mosque.toString();
      request.fields['school'] = school.toString();

      //
      request.fields['crime'] = crime.toString();
      request.fields['traffic'] = traffic.toString();
      request.fields['pollution'] = pollution.toString();
      request.fields['education'] = education.toString();
      request.fields['health'] = health.toString();
      //
      request.fields['doc_name'] = docName.toString();

      request.fields['owner_status'] = ownerStatus.toString();
      request.fields['owner_name'] = ownerName.toString();
      request.fields['owner_phone'] = ownerPhone.toString();
      request.fields['owner_email'] = ownerEmail.toString();
      request.fields['slight_negotiate'] = slightNegotiate.toString();

      var productImage =
          await http.MultipartFile.fromPath('property_image', image.path);
      var productDoc =
          await http.MultipartFile.fromPath('doc_file', docFile.path!);
      request.files.add(productImage);
      request.files.add(productDoc);

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //
        //   return status;
        // });
        return true;
      } else {
        showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
        return false;
      }
    } catch (ex) {
      print(ex.toString());
      showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );

      return false;
    }
  }

  static Future<List<PropertyModel?>?> getMyProducts(
      var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_my_product/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<List<PropertyModel?>?> getDisProduct(
      var page_num, var userId, var prodId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_dis_product/$page_num/$userId/$prodId'));
      // print(result.body);
      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<bool> editBasicDetail({
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
    required String slightNegotiate,
    required String user_id,
  }) async {
    String? newMode;
    if (props_mode == 'propertyModeEnum.New') {
      newMode = 'New';
    } else if (props_mode == 'propertyModeEnum.Furnished') {
      newMode = 'Furnished';
    } else {
      newMode = 'Serviced';
    }

    try {
      final uri = Uri.parse('$_mybaseUrl$_edit_basic/$user_id');
      var request = http.MultipartRequest('POST', uri);
      request.fields['propsName'] = propsName;
      request.fields['props_purpose'] = props_purpose;
      request.fields['props_type'] = props_type;
      request.fields['sub_props_type'] = sub_props_type;
      request.fields['propsBed'] = propsBed;
      request.fields['propsBath'] = propsBath;
      request.fields['propsToilet'] = propsToilet;
      request.fields['state_id'] = state_id;
      request.fields['area_id'] = area_id;
      request.fields['propsPrice'] = propsPrice;
      request.fields['propsDesc'] = propsDesc;
      request.fields['propsYearBuilt'] = propsYearBuilt;
      request.fields['props_mode'] = newMode;
      request.fields['propsYoutubeId'] = propsYoutubeId;
      request.fields['propsId'] = propsId;
      request.fields['slight_negotiate'] = slightNegotiate.toString();

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //   print(status);
        //
        //   // return status;
        // });
        return true;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> editExtraDetail({
    required String propsCondition,
    required String propsCautionFee,
    required String selectedPref,
    required String propsId,
    required String user_id,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_edit_extra/$user_id');
      var request = http.MultipartRequest('POST', uri);

      request.fields['propsCondition'] = propsCondition;
      request.fields['propsCautionFee'] = propsCautionFee;
      request.fields['selectedPref'] = selectedPref;
      request.fields['propsId'] = propsId;

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //
        //   return status;
        // });
        return true;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> editAmenties({
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
    try {
      final uri = Uri.parse('$_mybaseUrl$_edit_amenities/$user_id');
      var request = http.MultipartRequest('POST', uri);

      request.fields['air_condition'] = air_condition.toString();
      request.fields['balcony'] = balcony.toString();
      request.fields['bedding'] = bedding.toString();
      request.fields['cable_tv'] = cable_tv.toString();
      request.fields['cleaning_after_exist'] = cleaning_after_exist.toString();
      request.fields['coffee_pot'] = coffee_pot.toString();
      request.fields['computer'] = computer.toString();
      request.fields['cot'] = cot.toString();
      request.fields['dishwasher'] = dishwasher.toString();
      request.fields['dvd'] = dvd.toString();
      request.fields['fan'] = fan.toString();
      request.fields['fridge'] = fridge.toString();
      request.fields['grill'] = grill.toString();
      request.fields['hairdryer'] = hairdryer.toString();
      request.fields['heater'] = heater.toString();
      request.fields['hi_fi'] = hi_fi.toString();
      request.fields['internet'] = internet.toString();
      request.fields['iron'] = iron.toString();
      request.fields['juicer'] = juicer.toString();
      request.fields['lift'] = lift.toString();
      request.fields['microwave'] = microwave.toString();
      request.fields['gym'] = gym.toString();
      request.fields['fireplace'] = fireplace.toString();
      request.fields['hot_tub'] = hot_tub.toString();
      request.fields['propsId'] = propsId.toString();

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //
        //   return status;
        // });
        return true;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> editFacilities({
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
    try {
      final uri = Uri.parse('$_mybaseUrl$_edit_facilities/$user_id');
      var request = http.MultipartRequest('POST', uri);

      request.fields['shopping_mall'] = shopping.toString();
      request.fields['hospital'] = hospital.toString();
      request.fields['petrol_pump'] = petrol.toString();
      request.fields['airport'] = airport.toString();
      request.fields['church'] = church.toString();
      request.fields['mosque'] = mosque.toString();
      request.fields['school'] = school.toString();
      request.fields['propsId'] = propsId.toString();

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //
        //   return status;
        // });
        return true;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> editValuation({
    required String crime,
    required String traffic,
    required String pollution,
    required String education,
    required String health,
    required String propsId,
    required String user_id,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_edit_valuation/$user_id');
      var request = http.MultipartRequest('POST', uri);

      request.fields['crime'] = crime.toString();
      request.fields['traffic'] = traffic.toString();
      request.fields['pollution'] = pollution.toString();
      request.fields['education'] = education.toString();
      request.fields['health'] = health.toString();
      request.fields['propsId'] = propsId.toString();

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //
        //   return status;
        // });
        return true;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> editOwnershipStatus({
    required String owner_status,
    required String owner_name,
    required String owner_phone,
    required String owner_email,
    required String propsId,
    required String user_id,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_edit_ownership/$user_id');
      var request = http.MultipartRequest('POST', uri);

      request.fields['owner_status'] = owner_status.toString();
      request.fields['owner_name'] = owner_name.toString();
      request.fields['owner_phone'] = owner_phone.toString();
      request.fields['owner_email'] = owner_email.toString();
      request.fields['propsId'] = propsId.toString();

      var respond = await request.send();

      if (respond.statusCode == 200) {
        // respond.stream.transform(utf8.decoder).listen((value) {
        //   final j = json.decode(value) as Map<String, dynamic>;
        //   var status = j['status'];
        //
        //   return status;
        // });
        return true;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> deleteProps(var userId, var propsId, var imageId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_delete_props');

      var response = await http.post(uri, body: {
        'user_id': userId.toString(),
        'props_id': propsId.toString(),
        'image_id': imageId.toString(),
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future uploadImage({
    required String userId,
    required String propsId,
    required File image,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_update_image/$userId');
      var request = http.MultipartRequest('POST', uri);

      request.fields['user_id'] = userId.toString();
      request.fields['propsId'] = propsId.toString();

      var productImage =
          await http.MultipartFile.fromPath('property_image', image.path);
      request.files.add(productImage);

      var respond = await request.send();

      if (respond.statusCode == 200) {
        var result = await respond.stream.bytesToString();
        final j = json.decode(result) as Map<String, dynamic>;
        bool status = j['status'];
        // print('dis status $status');

        var imageList = <GetAllPropsImage>[];
        if (status) {
          String imgId = j['img_id'].toString();
          String imgName = j['image_name'].toString();
          String propsId = j['prod_id'].toString();
          GetAllPropsImage disImage =
              GetAllPropsImage(id: imgId, imageName: imgName, propId: propsId);

          imageList.add(disImage);
          return imageList;
        }
        // print('fallout');
        return false;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future uploadFeatureImage({
    required String userId,
    required String propsId,
    required File image,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_update_feature_image/$userId');
      var request = http.MultipartRequest('POST', uri);

      request.fields['user_id'] = userId.toString();
      request.fields['propsId'] = propsId.toString();

      var productImage =
          await http.MultipartFile.fromPath('property_image', image.path);
      request.files.add(productImage);

      var respond = await request.send();

      if (respond.statusCode == 200) {
        var result = await respond.stream.bytesToString();
        final j = json.decode(result) as Map<String, dynamic>;
        bool status = j['status'];

        if (status) {
          String imgName = j['slider_img'].toString();
          String propsId = j['prod_id'].toString();

          return imgName;
        }
        return false;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> submitProperty(var propsId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_submit_property/$propsId');

      final response = await client.get(uri);
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> deleteProperty(var propsId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_delete_property/$propsId');

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<PropertyModel?>?> manageProducts(
      var page_num, var userId, var type) async {
    try {
      final result = await client.get(
          Uri.parse('$_mybaseUrl$_manage_property/$page_num/$userId/$type'));
      // print(result.body);
      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product'] as List;

          final data = disData
              .map<PropertyModel>((json) => PropertyModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> approveProperty({
    required String propsId,
    required String userId,
    required String agentId,
  }) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrl$_approve_property/$propsId/$userId/$agentId');

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future rejectProperty({
    required String propsId,
    required String userId,
    required String agentId,
    required String message,
  }) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrl$_reject_property/$propsId/$userId/$agentId');
      var request = http.MultipartRequest('POST', uri);

      request.fields['message'] = message.toString();

      var respond = await request.send();

      if (respond.statusCode == 200) {
        var result = await respond.stream.bytesToString();
        final j = json.decode(result) as Map<String, dynamic>;
        bool status = j['status'];

        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<UsersModel?>?> getUsers(var pageNum) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_users/$pageNum');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['users'] as List;

          final data = disData
              .map<UsersModel>((json) => UsersModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<UsersModel?>?> getLandlords(var pageNum) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_landlords/$pageNum');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['users'] as List;

          final data = disData
              .map<UsersModel>((json) => UsersModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future toggleBan({required String UserId}) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_toggle_ban/$UserId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future deleteUser({required String UserId}) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_delete_user/$UserId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<bool> sendEmail({
    required String disUserId,
    required String fullName,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_message_user');

      var response = await http.post(uri, body: {
        'dis_user_id': disUserId,
        'email': email,
        'full_name': fullName,
        'subject': subject,
        'message': message,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> signUp({
    required String userName,
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String referalCode,
    required String isMlm,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrlSec$_signup');

      var response = await http.post(uri, body: {
        'user_name': userName.toString(),
        'full_name': fullName.toString(),
        'email': email.toString(),
        'phone': phone.toString(),
        'password': password.toString(),
        'is_mlm': isMlm.toString(),
        'mlm_ref_code': referalCode.toString(), //todo: come here zionnite
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          return 'true';
        } else {
          String msg = j['status_msg'];
          return msg;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrlSec$_login');

      var response = await http.post(uri, body: {
        'email': email.toString(),
        'password': password.toString(),
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String user_id = j['agent_id'];
          String user_name = j['agent_user_name'];
          String full_name = j['agent_full_name'];
          String email = j['agent_email'];
          String image_name = j['agent_image_name'];
          String status = j['agent_status'];
          String phone = j['agent_phone'];
          String age = j['agent_age'];
          String sex = j['agent_sex'];
          String address = j['agent_address'];
          String date_created = j['agent_date_created'];
          String account_name = j['agent_account_name'];
          String account_number = j['agent_account_number'];
          String bank_name = j['agent_bank_name'];
          String bank_code = j['agent_bank_code'];
          String current_balance = j['agent_current_balance'];
          String login_status = j['agent_login_status'];
          String prop_counter = j['agent_prop_counter'];
          bool admin_status = j['admin_status'];
          String isbank_verify = j['isbank_verify'];
          String m_ref_code = j['m_ref_code'];
          String m_ref_link = j['m_ref_link'];

          prefs.setString('user_id', user_id);
          prefs.setString('user_name', user_name);
          prefs.setString('full_name', full_name);
          prefs.setString('email', email);
          prefs.setString('image_name', image_name);
          prefs.setString('user_status', status);
          prefs.setString('phone', phone);
          prefs.setString('age', age);
          prefs.setString('sex', sex);
          prefs.setString('address', address);
          prefs.setString('date_created', date_created);
          prefs.setString('account_name', account_name);
          prefs.setString('account_number', account_number);
          prefs.setString('bank_name', bank_name);
          prefs.setString('bank_code', bank_code);
          prefs.setString('current_balance', current_balance);
          prefs.setString('login_status', login_status);
          prefs.setString('prop_counter', prop_counter);
          prefs.setBool('admin_status', admin_status);
          prefs.setString('isbank_verify', isbank_verify);
          prefs.setBool('isUserLogin', true);
          prefs.setBool('tempLoginStatus', true);
          prefs.setString('m_ref_code', m_ref_code);
          prefs.setString('m_ref_link', m_ref_link);

          var isGuestLogin = prefs.getBool('isGuestLogin');
          if (isGuestLogin != null) {
            prefs.remove("isGuestLogin");
          }

          return 'true';
        } else {
          String msg = j['status_msg'];
          return msg;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> resetPassword({required String email}) async {
    try {
      final uri = Uri.parse('$_mybaseUrlSec$_resetPassword');

      var response = await http.post(uri, body: {
        'email': email.toString(),
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          return 'true';
        } else {
          String msg = j['status_msg'];
          return msg;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> reportProperty({
    required String propsId,
    required String userId,
    required String type,
  }) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrl$_reportProperty/$propsId/$userId/$type');

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<UsersModel?>?> getDisUser(var userId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_dis_user/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['users'] as List;

          final data = disData
              .map<UsersModel>((json) => UsersModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> updateUserBio({
    required String fullName,
    required String email,
    required String phone,
    required String age,
    required String address,
    required String sex,
    required String my_id,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_update_profile/$my_id');

      var response = await http.post(uri, body: {
        'full_name': fullName.toString(),
        'email': email.toString(),
        'phone': phone.toString(),
        'age': age.toString(),
        'address': address.toString(),
        'sex': sex.toString(),
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String user_id = j['agent_id'];
          String user_name = j['agent_user_name'];
          String full_name = j['agent_full_name'];
          String email = j['agent_email'];
          String image_name = j['agent_image_name'];
          String status = j['agent_status'];
          String phone = j['agent_phone'];
          String age = j['agent_age'];
          String sex = j['agent_sex'];
          String address = j['agent_address'];
          String date_created = j['agent_date_created'];
          String account_name = j['agent_account_name'];
          String account_number = j['agent_account_number'];
          String bank_name = j['agent_bank_name'];
          String bank_code = j['agent_bank_code'];
          String current_balance = j['agent_current_balance'];
          String login_status = j['agent_login_status'];
          String prop_counter = j['agent_prop_counter'];
          bool admin_status = j['admin_status'];
          String isbank_verify = j['isbank_verify'];

          prefs.setString('user_id', user_id);
          prefs.setString('user_name', user_name);
          prefs.setString('full_name', full_name);
          prefs.setString('email', email);
          prefs.setString('image_name', image_name);
          prefs.setString('user_status', status);
          prefs.setString('phone', phone);
          prefs.setString('age', age);
          prefs.setString('sex', sex);
          prefs.setString('address', address);
          prefs.setString('date_created', date_created);
          prefs.setString('account_name', account_name);
          prefs.setString('account_number', account_number);
          prefs.setString('bank_name', bank_name);
          prefs.setString('bank_code', bank_code);
          prefs.setString('current_balance', current_balance);
          prefs.setString('login_status', login_status);
          prefs.setString('prop_counter', prop_counter);
          prefs.setBool('admin_status', admin_status);
          prefs.setString('isbank_verify', isbank_verify);

          return 'true';
        } else {
          String msg = j['status_msg'];
          return msg;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static getBankList() async {
    try {
      final result = await client.get(Uri.parse('$_mybaseUrl$_get_bank_list'));
      if (result.statusCode == 200) {
        BankModel data = bankModelFromJson(result.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> updateUserBank({
    required String accountName,
    required String accountNum,
    required String bankName,
    required String my_id,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_update_bank_detail/$my_id');

      var response = await http.post(uri, body: {
        'account_name': accountName.toString(),
        'account_num': accountNum.toString(),
        'bank_code': bankName.toString(),
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          String user_id = j['agent_id'];
          String user_name = j['agent_user_name'];
          String full_name = j['agent_full_name'];
          String email = j['agent_email'];
          String image_name = j['agent_image_name'];
          String status = j['agent_status'];
          String phone = j['agent_phone'];
          String age = j['agent_age'];
          String sex = j['agent_sex'];
          String address = j['agent_address'];
          String date_created = j['agent_date_created'];
          String account_name = j['agent_account_name'];
          String account_number = j['agent_account_number'];
          String bank_name = j['agent_bank_name'];
          String bank_code = j['agent_bank_code'];
          String current_balance = j['agent_current_balance'];
          String login_status = j['agent_login_status'];
          String prop_counter = j['agent_prop_counter'];
          bool admin_status = j['admin_status'];
          String isbank_verify = j['isbank_verify'];

          prefs.setString('user_id', user_id);
          prefs.setString('user_name', user_name);
          prefs.setString('full_name', full_name);
          prefs.setString('email', email);
          prefs.setString('image_name', image_name);
          prefs.setString('user_status', status);
          prefs.setString('phone', phone);
          prefs.setString('age', age);
          prefs.setString('sex', sex);
          prefs.setString('address', address);
          prefs.setString('date_created', date_created);
          prefs.setString('account_name', account_name);
          prefs.setString('account_number', account_number);
          prefs.setString('bank_name', bank_name);
          prefs.setString('bank_code', bank_code);
          prefs.setString('current_balance', current_balance);
          prefs.setString('login_status', login_status);
          prefs.setString('prop_counter', prop_counter);
          prefs.setBool('admin_status', admin_status);
          prefs.setString('isbank_verify', isbank_verify);

          return 'true';
        } else {
          String msg = j['status_msg'];
          return msg;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future uploadUserImage({
    required String userId,
    required File image,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_update_profile_image/$userId');
      var request = http.MultipartRequest('POST', uri);

      request.fields['user_id'] = userId.toString();

      var productImage =
          await http.MultipartFile.fromPath('property_image', image.path);
      request.files.add(productImage);

      var respond = await request.send();

      if (respond.statusCode == 200) {
        var result = await respond.stream.bytesToString();
        final j = json.decode(result) as Map<String, dynamic>;
        bool status = j['status'];

        if (status) {
          String image_name = j['image_name'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('image_name', image_name);
          return image_name;
        }
        return false;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> verifyBank({
    required String accountNum,
    required String bankCode,
    required String my_id,
  }) async {
    // print(accountNum);
    // print(bankCode);
    // print(my_id);
    try {
      final uri = Uri.parse(
          '$_mybaseUrl$_verify_bank_account/$my_id/$bankCode/$accountNum');

      var response = await http.post(uri);
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future countDashboard(
      var userId, var adminStatus, var userStatus) async {
    try {
      final result = await client.get(Uri.parse(
          '$_mybaseUrl$_count_dashboard/$userId/$adminStatus/$userStatus'));

      if (result.statusCode == 200) {
        final data = dashboardModelFromJson(result.body);

        return data;

        // var body = result.body;
        // final data = dashboardModelToJson(json.decode(body));
        // return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future countUnreadAlert(var userId) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_count_alert/$userId'));

      if (result.statusCode == 200) {
        final j = json.decode(result.body) as Map<String, dynamic>;
        int status = j['count_alert'];

        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future countUnreadMsg(var userId) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_count_msg/$userId'));

      if (result.statusCode == 200) {
        final j = json.decode(result.body) as Map<String, dynamic>;
        int status = j['count_msg'];

        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future checkIfBan(var userId) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_checkIfBan/$userId'));

      if (result.statusCode == 200) {
        final j = json.decode(result.body) as Map<String, dynamic>;
        bool status = j['status'];

        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future deleteAccount(var userId) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_deleteAccount/$userId'));

      if (result.statusCode == 200) {
        final j = json.decode(result.body) as Map<String, dynamic>;
        bool status = j['status'];

        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<int> isAppHasNewUpdate() async {
    final response = await http.get(Uri.parse('$_mybaseUrl$_has_new_update/'));

    Map<String, dynamic> j = json.decode(response.body);
    int counter = j['counter'];
    return counter;
  }

  static Future<String> iosStoreLink() async {
    final response = await http.get(Uri.parse('$_mybaseUrl$_ios_store_link/'));

    Map<String, dynamic> j = json.decode(response.body);
    String counter = j['link'];
    return counter;
  }

  static Future<String> androidStoreLink() async {
    final response =
        await http.get(Uri.parse('$_mybaseUrl$_android_store_link/'));

    Map<String, dynamic> j = json.decode(response.body);
    String counter = j['link'];
    return counter;
  }
  /**
   * Subscription Model
   */

  static Future<List<MlmTransaction?>?> getBlissTransaction(
      var pageNum, var userId, var adminStatus) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrlSec$_getTop20Transaction/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'admin_status': adminStatus.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;
        print(body);
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['mlm_transaction'] as List;

          final data = disData
              .map<MlmTransaction>((json) => MlmTransaction.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future countAccountReport(
      var userId, var adminStatus, var userStatus) async {
    try {
      final result = await client.get(Uri.parse(
          '$_mybaseUrlSec$_getAccountReport/$userId/$adminStatus/$userStatus'));

      if (result.statusCode == 200) {
        final data = accountReportModelFromJson(result.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<List<User?>?> getDownline(var pageNum, var userId) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrlSec$_get_direct_downline/$pageNum/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['users'] as List;

          final data =
              disData.map<User>((json) => User.fromJson(json)).toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<Plan?>?> getAllPlans(var pageNum, var userId) async {
    try {
      final uri = Uri.parse('$_mybaseUrlSec$_get_all_plans/$pageNum/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['plans'] as List;

          final data =
              disData.map<Plan>((json) => Plan.fromJson(json)).toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<Plan?>?> getDisPlansInterval(
      var pageNum, var planInterval, var userId) async {
    try {
      final uri = Uri.parse(
          '$_mybaseUrlSec$_get_all_plan_interval/$pageNum/$planInterval/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['plans'] as List;

          final data =
              disData.map<Plan>((json) => Plan.fromJson(json)).toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<Plan?>?> getDisPlansType(
      var pageNum, var planInterval, var userId) async {
    try {
      final uri = Uri.parse(
          '$_mybaseUrlSec$_get_all_plan_type/$pageNum/$planInterval/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['plans'] as List;

          final data =
              disData.map<Plan>((json) => Plan.fromJson(json)).toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<MyPlanList?>?> getSubscription(
      var pageNum, var userId) async {
    try {
      final uri = Uri.parse(
          '$_mybaseUrlSec$_get_my_subscription_list/$pageNum/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['my_plan_list'] as List;

          final data = disData
              .map<MyPlanList>((json) => MyPlanList.fromJson(json))
              .toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<Subscription?>?> getCardActivity(
      var pageNum, var planId, var userId) async {
    try {
      final uri = Uri.parse(
          '$_mybaseUrlSec$_get_my_subscription/$pageNum/$planId/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['subscription'] as List;

          final data = disData
              .map<Subscription>((json) => Subscription.fromJson(json))
              .toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future countSubscriptionItems(var userId, var planId) async {
    try {
      final result = await client.get(Uri.parse(
          '$_mybaseUrlSec$_get_subscription_counting/$userId/$planId'));

      if (result.statusCode == 200) {
        final data = countSubscriptionItemFromJson(result.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<String> toggleDisableButton({
    required String disId,
    required String userId,
    required String planId,
    required String planCode,
    required String subCode,
    required String emailToken,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrlSec$_toggle_disable_button');

      var response = await http.post(uri, body: {
        'dis_id': disId.toString(),
        'user_id': userId.toString(),
        'plan_id': planId.toString(),
        'plan_code': planCode.toString(),
        'sub_code': subCode.toString(),
        'email_token': emailToken.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;
        // print('body $body');

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> toggleUpdateCard(var userId, var subCode) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrlSec$_send_request_to_email/$userId/$subCode');

      var response = await http.post(uri, body: {
        'user_id': userId.toString(),
        'sub_code': subCode.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future joinSubscription(var userId, var planId, var planCode) async {
    try {
      final uri = Uri.parse(
          '$_mybaseUrlSec$_send_request_to_email/$userId/$planId/$planCode');

      var response = await http.post(uri, body: {
        'user_id': userId.toString(),
        'plan_id': planId.toString(),
        'plan_code': planCode.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        var link = j['link'];
        JoinSubscription(status: status, link: link);
        if (status == 'success') {
          return true;
        } else {
          return false;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<JoinSubscription?>?> joinSub(
      var userId, var planId, var plancode) async {
    try {
      final uri = Uri.parse(
          '$_mybaseUrlSec$_get_my_subscription/$userId/$planId/$plancode');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        final data = joinSubscriptionFromJson(result.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<PointItem?>?> getAllPointItem(
      var pageNum, var userId) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrlSec$_get_all_point_items/$pageNum/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['point_item'] as List;

          final data = disData
              .map<PointItem>((json) => PointItem.fromJson(json))
              .toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<List<MyPointItem?>?> getMyPointItem(
      var pageNum, var userId) async {
    try {
      final uri =
          Uri.parse('$_mybaseUrlSec$_get_my_point_items/$pageNum/$userId');

      final result = await client.get(uri);

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['my_point_item'] as List;

          final data = disData
              .map<MyPointItem>((json) => MyPointItem.fromJson(json))
              .toList();

          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future getPurchaseProduct(
      var page_num, var userId, var adminStatus) async {
    try {
      final result = await client.get(Uri.parse(
          '$_mybaseUrl$_all_purchase_product/$page_num/$userId/$adminStatus'));
      // print(result.body);
      if (result.statusCode == 200) {
        // final data = propertyModelFromJson(result.body);
        // retur data;
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['purchase_property'] as List;

          final data = disData
              .map<PurchaseProperty>((json) => PurchaseProperty.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future getReferal(var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_get_referal/$page_num/$userId'));

      if (result.statusCode == 200) {
        var body = result.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['users'] as List;

          final data = disData
              .map<UsersModel>((json) => UsersModel.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {}
  }

  static Future<String> makeRequestInspection(
      var name, var phone, var date, var time, var propsId, var agentId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_make_inspection_request');

      var response = await http.post(uri, body: {
        'props_id': propsId,
        'agent_id': agentId,
        'name': name,
        'phone': phone,
        'date': date,
        'time': time,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> makeRequestSpecification(var name, var phone, var desc,
      var location, var area, var budFrom, var budTo) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_make_request_specification');

      var response = await http.post(uri, body: {
        'name': name,
        'phone': phone,
        'description': desc,
        'location': location,
        'area': area,
        'budget_from': budFrom,
        'budget_to': budTo,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future getWithdrawal(var pageNum, var userId, var adminStatus) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_withdrawal/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'admin_status': adminStatus.toString(),
      });

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['withdrawal'] as List;

          final data = disData
              .map<Withdrawal>((json) => Withdrawal.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {}
  }

  static Future<String> requestWithdrawal(
      {required String userId, required String amount}) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_request_withdrawal');

      var response = await http.post(uri, body: {
        'user_id': userId,
        'amount': amount,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        Map<String, dynamic> j = json.decode(body);
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> approveWithdrawalRequest(
      {required String disUserId, required String Id}) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_approve_withdrawal');

      var response = await http.post(uri, body: {
        'user_id': disUserId,
        'id': Id,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        Map<String, dynamic> j = json.decode(body);
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> rejectWithdrawalRequest(
      {required String disUserId, required String Id}) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_reject_withdrawal');

      var response = await http.post(uri, body: {
        'user_id': disUserId,
        'id': Id,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        Map<String, dynamic> j = json.decode(body);
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> promoteProduct({
    required String userId,
    required String propsId,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_promote_product');

      var response = await http.post(uri, body: {
        'user_id': userId,
        'props_id': propsId,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future<String> copyProductLink({
    required String userId,
    required String propsId,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_copy_product_link');

      var response = await http.post(uri, body: {
        'user_id': userId,
        'props_id': propsId,
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  static Future getProductPromoting({
    required int pageNum,
    required String userId,
  }) async {
    try {
      final response = await client.get(
          Uri.parse('$_mybaseUrl$_get_product_promoting/$pageNum/$userId'));

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['product_promoting'] as List;

          final data = disData
              .map<ProductPromoting>((json) => ProductPromoting.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {}
  }

  static Future getLinkActivity({
    required int pageNum,
    required String userId,
    required String propsId,
  }) async {
    try {
      final response = await client.get(Uri.parse(
          '$_mybaseUrl$_get_link_activity/$pageNum/$userId/$propsId'));

      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['link_activity'] as List;

          final data = disData
              .map<LinkActivity>((json) => LinkActivity.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {}
  }

  static Future getPropertyDoc(var page_num, var userId, var propsId) async {
    try {
      final result = await client.get(
          Uri.parse('$_mybaseUrl$_get_doc_file/$page_num/$userId/$propsId'));
      if (result.statusCode == 200) {
        var body = result.body;
        final j = json.decode(body) as Map<String, dynamic>;
        String status = j['status'];
        if (status == 'success') {
          var disData = j['property_doc'] as List;

          final data = disData
              .map<PropertyDoc>((json) => PropertyDoc.fromJson(json))
              .toList();
          return data;
        }
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      // return showSnackBar(
      //   title: 'Oops!',
      //   msg: ex.toString(),
      //   backgroundColor: Colors.red,
      // );
    }
  }

  static Future<bool> uploadTitleDocument({
    String? doc_name,
    PlatformFile? doc_file,
    String? propsId,
    String? userId,
  }) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_upload_title_document/$userId');
      var request = http.MultipartRequest('POST', uri);
      request.fields['propsId'] = propsId.toString();
      request.fields['doc_name'] = doc_name.toString();

      var productDoc =
          await http.MultipartFile.fromPath('doc_file', doc_file!.path!);
      request.files.add(productDoc);

      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
        return false;
      }
    } catch (ex) {
      // print(ex);
      showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  static Future<bool> deleteDocFile(var userId, var fileId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_delete_doc_file');

      var response = await http.post(uri, body: {
        'user_id': userId.toString(),
        'file_id': fileId.toString(),
      });
      if (response.statusCode == 200) {
        var body = response.body;

        final j = json.decode(body) as Map<String, dynamic>;
        bool status = j['status'];
        return status;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      // print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
