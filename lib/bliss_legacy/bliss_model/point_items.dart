// To parse this JSON data, do
//
//     final pointItems = pointItemsFromJson(jsonString);

import 'dart:convert';

PointItems pointItemsFromJson(String str) =>
    PointItems.fromJson(json.decode(str));

String pointItemsToJson(PointItems data) => json.encode(data.toJson());

class PointItems {
  PointItems({
    this.status,
    this.pointItem,
  });

  String? status;
  List<PointItem>? pointItem;

  factory PointItems.fromJson(Map<String, dynamic> json) => PointItems(
        status: json["status"],
        pointItem: json["point_item"] == null
            ? []
            : List<PointItem>.from(
                json["point_item"]!.map((x) => PointItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "point_item": pointItem == null
            ? []
            : List<dynamic>.from(pointItem!.map((x) => x.toJson())),
      };
}

class PointItem {
  PointItem({
    this.disId,
    this.pointName,
    this.point,
    this.pointImage,
  });

  String? disId;
  String? pointName;
  String? point;
  String? pointImage;

  factory PointItem.fromJson(Map<String, dynamic> json) => PointItem(
        disId: json["dis_id"],
        pointName: json["point_name"],
        point: json["point"],
        pointImage: json["point_image"],
      );

  Map<String, dynamic> toJson() => {
        "dis_id": disId,
        "point_name": pointName,
        "point": point,
        "point_image": pointImage,
      };
}
