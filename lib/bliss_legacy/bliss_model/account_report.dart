// To parse this JSON data, do
//
//     final accountReportModel = accountReportModelFromJson(jsonString);

import 'dart:convert';

List<AccountReportModel> accountReportModelFromJson(String str) =>
    List<AccountReportModel>.from(
        json.decode(str).map((x) => AccountReportModel.fromJson(x)));

String accountReportModelToJson(List<AccountReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountReportModel {
  AccountReportModel({
    this.payableBalance,
    this.totalBalance,
    this.directDownline,
  });

  int? payableBalance;
  int? totalBalance;
  int? directDownline;

  factory AccountReportModel.fromJson(Map<String, dynamic> json) =>
      AccountReportModel(
        payableBalance: json["payable_balance"],
        totalBalance: json["total_balance"],
        directDownline: json["direct_downline"],
      );

  Map<String, dynamic> toJson() => {
        "payable_balance": payableBalance,
        "total_balance": totalBalance,
        "direct_downline": directDownline,
      };
}
