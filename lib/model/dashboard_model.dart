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
  String? totalEarning;
  String? totalTransaction;
  String? totalProperty;
  String? totalRequest;
  String? countAlert;
  String? totalAmountTransacted;
  String? payableBalance;
  String? referalBalance;
  String? totalAmountSubscribed;
  String? allUsers;
  String? countReferaal;
  String? countDownlines;

  DashboardModel({
    this.totalEarning,
    this.totalTransaction,
    this.totalProperty,
    this.totalRequest,
    this.countAlert,
    this.totalAmountTransacted,
    this.payableBalance,
    this.referalBalance,
    this.totalAmountSubscribed,
    this.allUsers,
    this.countReferaal,
    this.countDownlines,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        totalEarning: json["total_earning"],
        totalTransaction: json["total_transaction"],
        totalProperty: json["total_property"],
        totalRequest: json["total_request"],
        countAlert: json["count_alert"],
        totalAmountTransacted: json["total_amount_transacted"],
        payableBalance: json["payable_balance"],
        referalBalance: json["referal_balance"],
        totalAmountSubscribed: json["total_amount_subscribed"],
        allUsers: json["all_users"],
        countReferaal: json["count_referaal"],
        countDownlines: json["count_downlines"],
      );

  Map<String, dynamic> toJson() => {
        "total_earning": totalEarning,
        "total_transaction": totalTransaction,
        "total_property": totalProperty,
        "total_request": totalRequest,
        "count_alert": countAlert,
        "total_amount_transacted": totalAmountTransacted,
        "payable_balance": payableBalance,
        "referal_balance": referalBalance,
        "total_amount_subscribed": totalAmountSubscribed,
        "all_users": allUsers,
        "count_referaal": countReferaal,
        "count_downlines": countDownlines,
      };
}
