// To parse this JSON data, do
//
//     final myPointItems = myPointItemsFromJson(jsonString);

import 'dart:convert';

MyPointItems myPointItemsFromJson(String str) =>
    MyPointItems.fromJson(json.decode(str));

String myPointItemsToJson(MyPointItems data) => json.encode(data.toJson());

class MyPointItems {
  MyPointItems({
    this.status,
    this.myPointItem,
  });

  String? status;
  List<MyPointItem>? myPointItem;

  factory MyPointItems.fromJson(Map<String, dynamic> json) => MyPointItems(
        status: json["status"],
        myPointItem: json["my_point_item"] == null
            ? []
            : List<MyPointItem>.from(
                json["my_point_item"]!.map((x) => MyPointItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "my_point_item": myPointItem == null
            ? []
            : List<dynamic>.from(myPointItem!.map((x) => x.toJson())),
      };
}

class MyPointItem {
  MyPointItem({
    this.disId,
    this.userId,
    this.point,
    this.planListId,
    this.status,
    this.time,
    this.downlineId,
    this.downlineFullName,
    this.downlineUserName,
    this.downlineImage,
  });

  String? disId;
  String? userId;
  String? point;
  String? planListId;
  String? status;
  String? time;
  String? downlineId;
  String? downlineFullName;
  String? downlineUserName;
  String? downlineImage;

  factory MyPointItem.fromJson(Map<String, dynamic> json) => MyPointItem(
        disId: json["dis_id"],
        userId: json["user_id"],
        point: json["point"],
        planListId: json["plan_list_id"],
        status: json["status"],
        time: json["time"],
        downlineId: json["downline_id"],
        downlineFullName: json["downline_full_name"],
        downlineUserName: json["downline_user_name"],
        downlineImage: json["downline_image"],
      );

  Map<String, dynamic> toJson() => {
        "dis_id": disId,
        "user_id": userId,
        "point": point,
        "plan_list_id": planListId,
        "status": status,
        "time": time,
        "downline_id": downlineId,
        "downline_full_name": downlineFullName,
        "downline_user_name": downlineUserName,
        "downline_image": downlineImage,
      };
}
