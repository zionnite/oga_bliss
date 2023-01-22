// To parse this JSON data, do
//
//     final typesPropertyModel = typesPropertyModelFromJson(jsonString);

import 'dart:convert';

List<TypesPropertyModel> typesPropertyModelFromJson(String str) =>
    List<TypesPropertyModel>.from(
        json.decode(str).map((x) => TypesPropertyModel.fromJson(x)));

String typesPropertyModelToJson(List<TypesPropertyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypesPropertyModel {
  TypesPropertyModel({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory TypesPropertyModel.fromJson(Map<String, dynamic> json) =>
      TypesPropertyModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
