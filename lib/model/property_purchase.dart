// To parse this JSON data, do
//
//     final purchasePropertyModel = purchasePropertyModelFromJson(jsonString);

import 'dart:convert';

PurchasePropertyModel purchasePropertyModelFromJson(String str) =>
    PurchasePropertyModel.fromJson(json.decode(str));

String purchasePropertyModelToJson(PurchasePropertyModel data) =>
    json.encode(data.toJson());

class PurchasePropertyModel {
  String? status;
  List<PurchaseProperty>? purchaseProperty;

  PurchasePropertyModel({
    this.status,
    this.purchaseProperty,
  });

  factory PurchasePropertyModel.fromJson(Map<String, dynamic> json) =>
      PurchasePropertyModel(
        status: json["status"],
        purchaseProperty: json["purchase_property"] == null
            ? []
            : List<PurchaseProperty>.from(json["purchase_property"]!
                .map((x) => PurchaseProperty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "purchase_property": purchaseProperty == null
            ? []
            : List<dynamic>.from(purchaseProperty!.map((x) => x.toJson())),
      };
}

class PurchaseProperty {
  String? disId;
  String? propsId;
  String? propsAgentId;
  String? propsName;
  String? propsPrice;
  String? propsImgName;
  String? propStatus;
  DateTime? dateCreated;

  PurchaseProperty({
    this.disId,
    this.propsId,
    this.propsAgentId,
    this.propsName,
    this.propsPrice,
    this.propsImgName,
    this.propStatus,
    this.dateCreated,
  });

  factory PurchaseProperty.fromJson(Map<String, dynamic> json) =>
      PurchaseProperty(
        disId: json["disId"],
        propsId: json["props_id"],
        propsAgentId: json["props_agent_id"],
        propsName: json["props_name"],
        propsPrice: json["props_price"],
        propsImgName: json["props_img_name"],
        propStatus: json["propStatus"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "disId": disId,
        "props_id": propsId,
        "props_agent_id": propsAgentId,
        "props_name": propsName,
        "props_price": propsPrice,
        "props_img_name": propsImgName,
        "propStatus": propStatus,
        "date_created":
            "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
      };
}
