// To parse this JSON data, do
//
//     final linkActivityModel = linkActivityModelFromJson(jsonString);

import 'dart:convert';

LinkActivityModel linkActivityModelFromJson(String str) =>
    LinkActivityModel.fromJson(json.decode(str));

String linkActivityModelToJson(LinkActivityModel data) =>
    json.encode(data.toJson());

class LinkActivityModel {
  String? status;
  List<LinkActivity>? linkActivity;

  LinkActivityModel({
    this.status,
    this.linkActivity,
  });

  factory LinkActivityModel.fromJson(Map<String, dynamic> json) =>
      LinkActivityModel(
        status: json["status"],
        linkActivity: json["link_activity"] == null
            ? []
            : List<LinkActivity>.from(
                json["link_activity"]!.map((x) => LinkActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "link_activity": linkActivity == null
            ? []
            : List<dynamic>.from(linkActivity!.map((x) => x.toJson())),
      };
}

class LinkActivity {
  String? id;
  String? disUserId;
  String? propsId;
  String? promoterId;
  String? isRequested;
  String? urlCode;
  String? userFullName;
  String? userImageName;
  String? userUserName;

  LinkActivity({
    this.id,
    this.disUserId,
    this.propsId,
    this.promoterId,
    this.isRequested,
    this.urlCode,
    this.userFullName,
    this.userImageName,
    this.userUserName,
  });

  factory LinkActivity.fromJson(Map<String, dynamic> json) => LinkActivity(
        id: json["id"],
        disUserId: json["dis_user_id"],
        propsId: json["props_id"],
        promoterId: json["promoter_id"],
        isRequested: json["is_requested"],
        urlCode: json["url_code"],
        userFullName: json["user_full_name"],
        userImageName: json["user_image_name"],
        userUserName: json["user_user_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_user_id": disUserId,
        "props_id": propsId,
        "promoter_id": promoterId,
        "is_requested": isRequested,
        "url_code": urlCode,
        "user_full_name": userFullName,
        "user_image_name": userImageName,
        "user_user_name": userUserName,
      };
}
