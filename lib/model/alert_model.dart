// To parse this JSON data, do
//
//     final alertModel = alertModelFromJson(jsonString);

import 'dart:convert';

List<AlertModel> alertModelFromJson(String str) =>
    List<AlertModel>.from(json.decode(str).map((x) => AlertModel.fromJson(x)));

String alertModelToJson(List<AlertModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlertModel {
  AlertModel({
    this.id,
    this.disUserId,
    this.senderId,
    this.description,
    this.dateCreated,
    this.time,
    this.readStatus,
  });

  String? id;
  String? disUserId;
  String? senderId;
  String? description;
  DateTime? dateCreated;
  String? time;
  String? readStatus;

  factory AlertModel.fromJson(Map<String, dynamic> json) => AlertModel(
        id: json["id"],
        disUserId: json["dis_user_id"],
        senderId: json["sender_id"],
        description: json["description"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        time: json["time"],
        readStatus: json["read_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_user_id": disUserId,
        "sender_id": senderId,
        "description": description,
        "date_created": dateCreated?.toIso8601String(),
        "time": time,
        "read_status": readStatus,
      };
}
