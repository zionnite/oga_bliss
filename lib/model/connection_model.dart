// To parse this JSON data, do
//
//     final connectionModel = connectionModelFromJson(jsonString);

import 'dart:convert';

List<ConnectionModel> connectionModelFromJson(String str) =>
    List<ConnectionModel>.from(
        json.decode(str).map((x) => ConnectionModel.fromJson(x)));

String connectionModelToJson(List<ConnectionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConnectionModel {
  ConnectionModel({
    this.id,
    this.disUserId,
    this.agentId,
    this.time,
    this.date,
    this.propsId,
    this.getUserFullName,
    this.getUserImage,
    this.getUserEmail,
    this.getUserStatus,
    this.getUserName,
    this.getAgentFullName,
    this.getAgentImage,
    this.getAgentEmail,
    this.getAgentStatus,
    this.getAgentUserName,
    this.propsName,
  });

  dynamic? id;
  dynamic? disUserId;
  dynamic? agentId;
  dynamic? time;
  DateTime? date;
  dynamic? propsId;
  dynamic? getUserFullName;
  dynamic? getUserImage;
  dynamic? getUserEmail;
  dynamic? getUserStatus;
  dynamic? getUserName;
  dynamic getAgentFullName;
  dynamic? getAgentImage;
  dynamic getAgentEmail;
  dynamic getAgentStatus;
  dynamic getAgentUserName;
  dynamic? propsName;

  factory ConnectionModel.fromJson(Map<String, dynamic> json) =>
      ConnectionModel(
        id: json["id"],
        disUserId: json["dis_user_id"],
        agentId: json["agent_id"],
        time: json["time"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        propsId: json["props_id"],
        getUserFullName: json["get_user_full_name"],
        getUserImage: json["get_user_image"],
        getUserEmail: json["get_user_email"],
        getUserStatus: json["get_user_status"],
        getUserName: json["get_user_name"],
        getAgentFullName: json["get_agent_full_name"],
        getAgentImage: json["get_agent_image"],
        getAgentEmail: json["get_agent_email"],
        getAgentStatus: json["get_agent_status"],
        getAgentUserName: json["get_agent_user_name"],
        propsName: json["props_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_user_id": disUserId,
        "agent_id": agentId,
        "time": time,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "props_id": propsId,
        "get_user_full_name": getUserFullName,
        "get_user_image": getUserImage,
        "get_user_email": getUserEmail,
        "get_user_status": getUserStatus,
        "get_user_name": getUserName,
        "get_agent_full_name": getAgentFullName,
        "get_agent_image": getAgentImage,
        "get_agent_email": getAgentEmail,
        "get_agent_status": getAgentStatus,
        "get_agent_user_name": getAgentUserName,
        "props_name": propsName,
      };
}
