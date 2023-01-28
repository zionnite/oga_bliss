// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

List<WalletModel> walletModelFromJson(String str) => List<WalletModel>.from(
    json.decode(str).map((x) => WalletModel.fromJson(x)));

String walletModelToJson(List<WalletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletModel {
  WalletModel({
    this.id,
    this.disUserId,
    this.agentId,
    this.propsId,
    this.amount,
    this.fullDate,
    this.month,
    this.day,
    this.year,
    this.time,
    this.transType,
    this.transStatus,
    this.isPay,
    this.isRequested,
    this.propsName,
    this.propsImage,
    this.getPropsStateId,
    this.getStateName,
    this.getPropsSubStateId,
    this.getSubStateName,
  });

  String? id;
  String? disUserId;
  String? agentId;
  String? propsId;
  String? amount;
  DateTime? fullDate;
  String? month;
  String? day;
  String? year;
  String? time;
  String? transType;
  String? transStatus;
  String? isPay;
  String? isRequested;
  String? propsName;
  String? propsImage;
  String? getPropsStateId;
  String? getStateName;
  String? getPropsSubStateId;
  String? getSubStateName;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        id: json["id"],
        disUserId: json["dis_user_id"],
        agentId: json["agent_id"],
        propsId: json["props_id"],
        amount: json["amount"],
        fullDate: json["full_date"] == null
            ? null
            : DateTime.parse(json["full_date"]),
        month: json["month"],
        day: json["day"],
        year: json["year"],
        time: json["time"],
        transType: json["trans_type"],
        transStatus: json["trans_status"],
        isPay: json["is_pay"],
        isRequested: json["is_requested"],
        propsName: json["props_name"],
        propsImage: json["props_image"],
        getPropsStateId: json["get_props_state_id"],
        getStateName: json["get_state_name"],
        getPropsSubStateId: json["get_props_sub_state_id"],
        getSubStateName: json["get_sub_state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_user_id": disUserId,
        "agent_id": agentId,
        "props_id": propsId,
        "amount": amount,
        "full_date": fullDate?.toIso8601String(),
        "month": month,
        "day": day,
        "year": year,
        "time": time,
        "trans_type": transType,
        "trans_status": transStatus,
        "is_pay": isPay,
        "is_requested": isRequested,
        "props_name": propsName,
        "props_image": propsImage,
        "get_props_state_id": getPropsStateId,
        "get_state_name": getStateName,
        "get_props_sub_state_id": getPropsSubStateId,
        "get_sub_state_name": getSubStateName,
      };
}
