// To parse this JSON data, do
//
//     final blissDownlineModel = blissDownlineModelFromJson(jsonString);

import 'dart:convert';

BlissDownlineModel blissDownlineModelFromJson(String str) =>
    BlissDownlineModel.fromJson(json.decode(str));

String blissDownlineModelToJson(BlissDownlineModel data) =>
    json.encode(data.toJson());

class BlissDownlineModel {
  BlissDownlineModel({
    this.status,
    this.users,
  });

  String? status;
  List<User>? users;

  factory BlissDownlineModel.fromJson(Map<String, dynamic> json) =>
      BlissDownlineModel(
        status: json["status"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.agentId,
    this.agentUserName,
    this.agentFullName,
    this.agentEmail,
    this.agentImageName,
    this.agentStatus,
    this.agentPhone,
    this.agentAge,
    this.agentSex,
    this.agentAddress,
    this.agentDateCreated,
    this.agentAccountName,
    this.agentAccountNumber,
    this.agentBankName,
    this.agentBankCode,
    this.agentCurrentBalance,
    this.agentLoginStatus,
    this.agentPropCounter,
    this.isbankVerify,
    this.countSub,
    this.countDownline,
    this.amountEarned,
  });

  String? agentId;
  String? agentUserName;
  String? agentFullName;
  String? agentEmail;
  String? agentImageName;
  String? agentStatus;
  String? agentPhone;
  String? agentAge;
  String? agentSex;
  String? agentAddress;
  DateTime? agentDateCreated;
  String? agentAccountName;
  String? agentAccountNumber;
  String? agentBankName;
  String? agentBankCode;
  String? agentCurrentBalance;
  String? agentLoginStatus;
  int? agentPropCounter;
  String? isbankVerify;
  int? countSub;
  int? countDownline;
  String? amountEarned;

  factory User.fromJson(Map<String, dynamic> json) => User(
        agentId: json["agent_id"],
        agentUserName: json["agent_user_name"],
        agentFullName: json["agent_full_name"],
        agentEmail: json["agent_email"],
        agentImageName: json["agent_image_name"],
        agentStatus: json["agent_status"],
        agentPhone: json["agent_phone"],
        agentAge: json["agent_age"],
        agentSex: json["agent_sex"],
        agentAddress: json["agent_address"],
        agentDateCreated: json["agent_date_created"] == null
            ? null
            : DateTime.parse(json["agent_date_created"]),
        agentAccountName: json["agent_account_name"],
        agentAccountNumber: json["agent_account_number"],
        agentBankName: json["agent_bank_name"],
        agentBankCode: json["agent_bank_code"],
        agentCurrentBalance: json["agent_current_balance"],
        agentLoginStatus: json["agent_login_status"],
        agentPropCounter: json["agent_prop_counter"],
        isbankVerify: json["isbank_verify"],
        countSub: json["count_sub"],
        countDownline: json["count_downline"],
        amountEarned: json["amount_earned"],
      );

  Map<String, dynamic> toJson() => {
        "agent_id": agentId,
        "agent_user_name": agentUserName,
        "agent_full_name": agentFullName,
        "agent_email": agentEmail,
        "agent_image_name": agentImageName,
        "agent_status": agentStatus,
        "agent_phone": agentPhone,
        "agent_age": agentAge,
        "agent_sex": agentSex,
        "agent_address": agentAddress,
        "agent_date_created":
            "${agentDateCreated!.year.toString().padLeft(4, '0')}-${agentDateCreated!.month.toString().padLeft(2, '0')}-${agentDateCreated!.day.toString().padLeft(2, '0')}",
        "agent_account_name": agentAccountName,
        "agent_account_number": agentAccountNumber,
        "agent_bank_name": agentBankName,
        "agent_bank_code": agentBankCode,
        "agent_current_balance": agentCurrentBalance,
        "agent_login_status": agentLoginStatus,
        "agent_prop_counter": agentPropCounter,
        "isbank_verify": isbankVerify,
        "count_sub": countSub,
        "count_downline": countDownline,
        "amount_earned": amountEarned,
      };
}
