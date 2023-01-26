import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/connection_model.dart';
import '../model/property_model.dart';
import '../model/request_model.dart';
import '../model/state_model.dart';
import '../model/transaction_model.dart';
import '../model/types_property_model.dart';
import '../util/common.dart';

class ApiServices {
  static var client = http.Client();
  static const String _mybaseUrl = 'http://localhost:8888/ogalandlord/Api/';

  static const String _all_product = 'get_all_product';
  static const String _toggle_product = 'toggle_product';
  static const String _request_inspection = 'request_inspection';
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

  static Future<List<PropertyModel?>?> getAllProducts(
      var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_all_product/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        final data = propertyModelFromJson(result.body);
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

  static Future<String> toggleLike(var userId, var propsId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_toggle_product');

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
        final data = propertyModelFromJson(response.body);
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
        final data = propertyModelFromJson(response.body);
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

  static getFilterProductType(var page_num, var userId, var typeId) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_filter_type/$page_num/$userId');

      var response = await http.post(uri, body: {
        'type_id': typeId,
      });

      if (response.statusCode == 200) {
        final data = propertyModelFromJson(response.body);
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

  static getFilterProductPrice(
      var page_num, var userId, var start_price, var end_price) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_filter_price/$page_num/$userId');

      var response = await http.post(uri, body: {
        'start_price': start_price,
        'end_price': end_price,
      });

      if (response.statusCode == 200) {
        final data = propertyModelFromJson(response.body);
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

  static Future<List<PropertyModel?>?> getAllFav(
      var page_num, var userId) async {
    try {
      final result = await client
          .get(Uri.parse('$_mybaseUrl$_get_favourite/$page_num/$userId'));
      // print(result.body);
      if (result.statusCode == 200) {
        final data = propertyModelFromJson(result.body);
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

  static Future<List<RequestModel>> getRequest(
      var pageNum, var userId, var adminStatus) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_requeest/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'admin_status': adminStatus.toString(),
      });

      if (response.statusCode == 200) {
        final data = requestModelFromJson(response.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
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
        final data = connectionModelFromJson(result.body);
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

  static Future<List<TransactionModel>> getTransaction(
      var pageNum, var userId, var adminStatus) async {
    try {
      final uri = Uri.parse('$_mybaseUrl$_get_transaction/$pageNum/$userId');

      var response = await http.post(uri, body: {
        'admin_status': adminStatus.toString(),
      });

      if (response.statusCode == 200) {
        final data = transactionModelFromJson(response.body);
        return data;
      } else {
        return showSnackBar(
          title: 'Oops!',
          msg: 'could not connect to server',
          backgroundColor: Colors.red,
        );
      }
    } catch (ex) {
      print(ex.toString());
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
