// To parse this JSON data, do
//
//     final marketerModel = marketerModelFromJson(jsonString);

import 'dart:convert';

MarketerModel marketerModelFromJson(String str) =>
    MarketerModel.fromJson(json.decode(str));

String marketerModelToJson(MarketerModel data) => json.encode(data.toJson());

class MarketerModel {
  String? status;
  List<ProductPromoting>? productPromoting;

  MarketerModel({
    this.status,
    this.productPromoting,
  });

  factory MarketerModel.fromJson(Map<String, dynamic> json) => MarketerModel(
        status: json["status"],
        productPromoting: json["product_promoting"] == null
            ? []
            : List<ProductPromoting>.from(json["product_promoting"]!
                .map((x) => ProductPromoting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "product_promoting": productPromoting == null
            ? []
            : List<dynamic>.from(productPromoting!.map((x) => x.toJson())),
      };
}

class ProductPromoting {
  String? id;
  String? propsId;
  String? urlCode;
  String? propsAmount;
  String? propsName;
  String? propsImage;
  String? propsComm;
  String? getPromoterCom;
  int? promoterPerc;
  int? countDownline;

  ProductPromoting({
    this.id,
    this.propsId,
    this.urlCode,
    this.propsAmount,
    this.propsName,
    this.propsImage,
    this.propsComm,
    this.getPromoterCom,
    this.promoterPerc,
    this.countDownline,
  });

  factory ProductPromoting.fromJson(Map<String, dynamic> json) =>
      ProductPromoting(
        id: json["id"],
        propsId: json["props_id"],
        urlCode: json["url_code"],
        propsAmount: json["props_amount"],
        propsName: json["props_name"],
        propsImage: json["props_image"],
        propsComm: json["props_comm"],
        getPromoterCom: json["get_promoter_com"],
        promoterPerc: json["promoter_perc"],
        countDownline: json["count_downline"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "props_id": propsId,
        "url_code": urlCode,
        "props_amount": propsAmount,
        "props_name": propsName,
        "props_image": propsImage,
        "props_comm": propsComm,
        "get_promoter_com": getPromoterCom,
        "promoter_perc": promoterPerc,
        "count_downline": countDownline,
      };
}
