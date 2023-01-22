// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  LocationModel({
    required this.states,
    required this.area,
  });

  List<States> states;
  List<Area> area;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        states:
            List<States>.from(json["states"].map((x) => States.fromJson(x))),
        area: List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
        "area": List<dynamic>.from(area.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    required this.id,
    required this.stateId,
    required this.name,
  });

  String id;
  String stateId;
  String name;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        stateId: json["state_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state_id": stateId,
        "name": name,
      };
}

class States {
  States({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
