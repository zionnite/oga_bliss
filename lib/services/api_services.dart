import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/property_model.dart';
import '../util/common.dart';

class ApiServices {
  static var client = http.Client();
  static const String _mybaseUrl = 'http://localhost:8888/ogalandlord/Api/';

  static const String _all_product = 'get_all_product';
  static const String _toggle_product = 'toggle_product';
  static const String _request_inspection = 'request_inspection';

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
    final uri = Uri.parse('$_mybaseUrl$_toggle_product');

    var response = await http.post(uri, body: {
      'user_id': userId,
      'props_id': propsId,
    });

    var body = response.body;

    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }

  static Future<String> requestInspection(
      var userId, var propsId, var agentId) async {
    final uri = Uri.parse('$_mybaseUrl$_request_inspection');

    var response = await http.post(uri, body: {
      'user_id': userId,
      'props_id': propsId,
      'agent_id': agentId,
    });

    var body = response.body;

    final j = json.decode(body) as Map<String, dynamic>;
    String status = j['status'];
    return status;
  }
}
