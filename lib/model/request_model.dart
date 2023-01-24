// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

List<RequestModel> requestModelFromJson(String str) => List<RequestModel>.from(
    json.decode(str).map((x) => RequestModel.fromJson(x)));

String requestModelToJson(List<RequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestModel {
  RequestModel({
    this.id,
    this.disUserId,
    this.agentId,
    this.propsId,
    this.title,
    this.description,
    this.dateCreated,
    this.time,
    this.userReadStatus,
    this.agentReadStatus,
    this.adminReadStatus,
    this.requestStatus,
    this.propsName,
    this.propsName2,
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
  String? title;
  String? description;
  DateTime? dateCreated;
  String? time;
  String? userReadStatus;
  String? agentReadStatus;
  String? adminReadStatus;
  String? requestStatus;
  String? propsName;
  String? propsName2;
  String? propsImage;
  String? getPropsStateId;
  String? getStateName;
  String? getPropsSubStateId;
  String? getSubStateName;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["id"],
        disUserId: json["dis_user_id"],
        agentId: json["agent_id"],
        propsId: json["props_id"],
        title: json["title"],
        description: json["description"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        time: json["time"],
        userReadStatus: json["user_read_status"],
        agentReadStatus: json["agent_read_status"],
        adminReadStatus: json["admin_read_status"],
        requestStatus: json["request_status"],
        propsName: json["props_name"],
        propsName2: json["props_name_2"],
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
        "title": title,
        "description": description,
        "date_created": dateCreated?.toIso8601String(),
        "time": time,
        "user_read_status": userReadStatus,
        "agent_read_status": agentReadStatus,
        "admin_read_status": adminReadStatus,
        "request_status": requestStatus,
        "props_name": propsName,
        "props_name_2": propsName2,
        "props_image": propsImage,
        "get_props_state_id": getPropsStateId,
        "get_state_name": getStateName,
        "get_props_sub_state_id": getPropsSubStateId,
        "get_sub_state_name": getSubStateName,
      };
}
