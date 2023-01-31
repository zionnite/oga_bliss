// To parse this JSON data, do
//
//     final propertyAndSubTypesModel = propertyAndSubTypesModelFromJson(jsonString);

import 'dart:convert';

PropertyAndSubTypesModel propertyAndSubTypesModelFromJson(String str) =>
    PropertyAndSubTypesModel.fromJson(json.decode(str));

String propertyAndSubTypesModelToJson(PropertyAndSubTypesModel data) =>
    json.encode(data.toJson());

class PropertyAndSubTypesModel {
  PropertyAndSubTypesModel({
    this.property,
    this.subProperty,
  });

  List<Property>? property;
  List<SubProperty>? subProperty;

  factory PropertyAndSubTypesModel.fromJson(Map<String, dynamic> json) =>
      PropertyAndSubTypesModel(
        property: json["property"] == null
            ? []
            : List<Property>.from(
                json["property"]!.map((x) => Property.fromJson(x))),
        subProperty: json["sub_property"] == null
            ? []
            : List<SubProperty>.from(
                json["sub_property"]!.map((x) => SubProperty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "property": property == null
            ? []
            : List<dynamic>.from(property!.map((x) => x.toJson())),
        "sub_property": subProperty == null
            ? []
            : List<dynamic>.from(subProperty!.map((x) => x.toJson())),
      };
}

class Property {
  Property({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SubProperty {
  SubProperty({
    this.id,
    this.typeId,
    this.name,
  });

  String? id;
  String? typeId;
  String? name;

  factory SubProperty.fromJson(Map<String, dynamic> json) => SubProperty(
        id: json["id"],
        typeId: json["type_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "name": name,
      };
}
