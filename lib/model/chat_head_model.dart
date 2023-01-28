// To parse this JSON data, do
//
//     final chatHeadModel = chatHeadModelFromJson(jsonString);

import 'dart:convert';

List<ChatHeadModel> chatHeadModelFromJson(String str) =>
    List<ChatHeadModel>.from(
        json.decode(str).map((x) => ChatHeadModel.fromJson(x)));

String chatHeadModelToJson(List<ChatHeadModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatHeadModel {
  ChatHeadModel({
    this.id,
    this.disMyId,
    this.disUserId,
    this.propsId,
    this.disMyFullName,
    this.disMyImageName,
    this.disMyEmail,
    this.disMyUserName,
    this.disMyUserStatus,
    this.disUserFullName,
    this.disUserImageName,
    this.disUserEmail,
    this.disUserUserName,
    this.disUserUserStatus,
    this.lastMsg,
    this.lastTimeMsg,
    this.countUnreadMsg,
  });

  String? id;
  String? disMyId;
  String? disUserId;
  String? propsId;
  String? disMyFullName;
  String? disMyImageName;
  String? disMyEmail;
  String? disMyUserName;
  String? disMyUserStatus;
  String? disUserFullName;
  String? disUserImageName;
  String? disUserEmail;
  String? disUserUserName;
  String? disUserUserStatus;
  dynamic? lastMsg;
  dynamic? lastTimeMsg;
  dynamic? countUnreadMsg;

  factory ChatHeadModel.fromJson(Map<String, dynamic> json) => ChatHeadModel(
        id: json["id"],
        disMyId: json["dis_my_id"],
        disUserId: json["dis_user_id"],
        propsId: json["props_id"],
        disMyFullName: json["dis_my_full_name"],
        disMyImageName: json["dis_my_image_name"],
        disMyEmail: json["dis_my_email"],
        disMyUserName: json["dis_my_user_name"],
        disMyUserStatus: json["dis_my_user_status"],
        disUserFullName: json["dis_user_full_name"],
        disUserImageName: json["dis_user_image_name"],
        disUserEmail: json["dis_user_email"],
        disUserUserName: json["dis_user_user_name"],
        disUserUserStatus: json["dis_user_user_status"],
        lastMsg: json["last_msg"],
        lastTimeMsg: json["last_time_msg"],
        countUnreadMsg: json["count_unread_msg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_my_id": disMyId,
        "dis_user_id": disUserId,
        "props_id": propsId,
        "dis_my_full_name": disMyFullName,
        "dis_my_image_name": disMyImageName,
        "dis_my_email": disMyEmail,
        "dis_my_user_name": disMyUserName,
        "dis_my_user_status": disMyUserStatus,
        "dis_user_full_name": disUserFullName,
        "dis_user_image_name": disUserImageName,
        "dis_user_email": disUserEmail,
        "dis_user_user_name": disUserUserName,
        "dis_user_user_status": disUserUserStatus,
        "last_msg": lastMsg,
        "last_time_msg": lastTimeMsg,
        "count_unread_msg": countUnreadMsg,
      };
}
