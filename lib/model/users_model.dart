// To parse this JSON data, do
//
//     final usersModel = usersModelFromJson(jsonString);

import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) =>
    List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  UsersModel({
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
  dynamic agentDateCreated;
  String? agentAccountName;
  String? agentAccountNumber;
  String? agentBankName;
  String? agentBankCode;
  String? agentCurrentBalance;
  String? agentLoginStatus;
  int? agentPropCounter;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
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
        agentDateCreated: json["agent_date_created"],
        agentAccountName: json["agent_account_name"],
        agentAccountNumber: json["agent_account_number"],
        agentBankName: json["agent_bank_name"],
        agentBankCode: json["agent_bank_code"],
        agentCurrentBalance: json["agent_current_balance"],
        agentLoginStatus: json["agent_login_status"],
        agentPropCounter: json["agent_prop_counter"],
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
        "agent_date_created": agentDateCreated,
        "agent_account_name": agentAccountName,
        "agent_account_number": agentAccountNumber,
        "agent_bank_name": agentBankName,
        "agent_bank_code": agentBankCode,
        "agent_current_balance": agentCurrentBalance,
        "agent_login_status": agentLoginStatus,
        "agent_prop_counter": agentPropCounter,
      };
}
