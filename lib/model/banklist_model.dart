// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    this.status,
    this.bankList,
  });

  bool? status;
  List<BankList>? bankList;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        status: json["status"],
        bankList: json["bank_list"] == null
            ? []
            : List<BankList>.from(
                json["bank_list"]!.map((x) => BankList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "bank_list": bankList == null
            ? []
            : List<dynamic>.from(bankList!.map((x) => x.toJson())),
      };
}

class BankList {
  BankList({
    this.id,
    this.bankName,
    this.bankCode,
  });

  String? id;
  String? bankName;
  String? bankCode;

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
        id: json["id"],
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "bank_code": bankCode,
      };
}
