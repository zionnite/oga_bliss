// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

List<DashboardModel> dashboardModelFromJson(String str) =>
    List<DashboardModel>.from(
        json.decode(str).map((x) => DashboardModel.fromJson(x)));

String dashboardModelToJson(List<DashboardModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashboardModel {
  DashboardModel({
    this.totalEarning,
    this.walletBalance,
    this.insuranceEarning,
    this.totalTransaction,
    this.totalConnection,
    this.totalProperty,
    this.totalRequest,
    this.countMsg,
    this.countAlert,
  });

  String? totalEarning;
  String? walletBalance;
  String? insuranceEarning;
  String? totalTransaction;
  String? totalConnection;
  String? totalProperty;
  String? totalRequest;
  String? countMsg;
  String? countAlert;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        totalEarning: json["total_earning"],
        walletBalance: json["wallet_balance"],
        insuranceEarning: json["insurance_earning"],
        totalTransaction: json["total_transaction"],
        totalConnection: json["total_connection"],
        totalProperty: json["total_property"],
        totalRequest: json["total_request"],
        countMsg: json["count_msg"],
        countAlert: json["count_alert"],
      );

  Map<String, dynamic> toJson() => {
        "total_earning": totalEarning,
        "wallet_balance": walletBalance,
        "insurance_earning": insuranceEarning,
        "total_transaction": totalTransaction,
        "total_connection": totalConnection,
        "total_property": totalProperty,
        "total_request": totalRequest,
        "count_msg": countMsg,
        "count_alert": countAlert,
      };
}
