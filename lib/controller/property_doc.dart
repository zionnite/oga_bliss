// To parse this JSON data, do
//
//     final propertyDocument = propertyDocumentFromJson(jsonString);

import 'dart:convert';

PropertyDocument propertyDocumentFromJson(String str) =>
    PropertyDocument.fromJson(json.decode(str));

String propertyDocumentToJson(PropertyDocument data) =>
    json.encode(data.toJson());

class PropertyDocument {
  String? status;
  List<PropertyDoc>? propertyDoc;

  PropertyDocument({
    this.status,
    this.propertyDoc,
  });

  factory PropertyDocument.fromJson(Map<String, dynamic> json) =>
      PropertyDocument(
        status: json["status"],
        propertyDoc: json["property_doc"] == null
            ? []
            : List<PropertyDoc>.from(
                json["property_doc"]!.map((x) => PropertyDoc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "property_doc": propertyDoc == null
            ? []
            : List<dynamic>.from(propertyDoc!.map((x) => x.toJson())),
      };
}

class PropertyDoc {
  String? id;
  String? title;
  String? fileName;
  String? fileExt;

  PropertyDoc({
    this.id,
    this.title,
    this.fileName,
    this.fileExt,
  });

  factory PropertyDoc.fromJson(Map<String, dynamic> json) => PropertyDoc(
        id: json["id"],
        title: json["title"],
        fileName: json["file_name"],
        fileExt: json["file_ext"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "file_name": fileName,
        "file_ext": fileExt,
      };
}
