// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

List<TransactionModel> transactionModelFromJson(String str) =>
    List<TransactionModel>.from(
        json.decode(str).map((x) => TransactionModel.fromJson(x)));

String transactionModelToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {
  TransactionModel({
    this.id,
    this.propsId,
    this.disUserId,
    this.disAmount,
    this.transType,
    this.disBalance,
    this.description,
    this.refNo,
    this.disStatus,
    this.dateCreated,
    this.time,
    this.propsName,
    this.propsImage,
    this.getPropsStateId,
    this.getStateName,
    this.getPropsSubStateId,
    this.getSubStateName,
  });

  String? id;
  String? propsId;
  String? disUserId;
  String? disAmount;
  String? transType;
  String? disBalance;
  String? description;
  String? refNo;
  String? disStatus;
  DateTime? dateCreated;
  String? time;
  String? propsName;
  String? propsImage;
  String? getPropsStateId;
  String? getStateName;
  String? getPropsSubStateId;
  String? getSubStateName;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        propsId: json["props_id"],
        disUserId: json["dis_user_id"],
        disAmount: json["dis_amount"],
        transType: json["trans_type"],
        disBalance: json["dis_balance"],
        description: json["description"],
        refNo: json["ref_no"],
        disStatus: json["dis_status"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        time: json["time"],
        propsName: json["props_name"],
        propsImage: json["props_image"],
        getPropsStateId: json["get_props_state_id"],
        getStateName: json["get_state_name"],
        getPropsSubStateId: json["get_props_sub_state_id"],
        getSubStateName: json["get_sub_state_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "props_id": propsId,
        "dis_user_id": disUserId,
        "dis_amount": disAmount,
        "trans_type": transType,
        "dis_balance": disBalance,
        "description": description,
        "ref_no": refNo,
        "dis_status": disStatus,
        "date_created": dateCreated?.toIso8601String(),
        "time": time,
        "props_name": propsName,
        "props_image": propsImage,
        "get_props_state_id": getPropsStateId,
        "get_state_name": getStateName,
        "get_props_sub_state_id": getPropsSubStateId,
        "get_sub_state_name": getSubStateName,
      };
}
