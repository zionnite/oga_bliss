import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/property_model.dart';
import '../util/common.dart';

class ApiServices {
  static var client = http.Client();
  static const String _mybaseUrl = 'http://localhost:8888/ogalandlord/Api/';

  static const String _all_product = 'get_all_product';

  static Future<List<PropertyModel?>?> getAllProducts(
      var page_num, var userId) async {
    try {
      final result =
          await client.get(Uri.parse('$_mybaseUrl$_all_product/$userId'));
      print(result.body);
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
      print(ex);
      return showSnackBar(
        title: 'Oops!',
        msg: ex.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
