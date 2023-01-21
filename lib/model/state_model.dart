// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

List<StateModel> stateModelFromJson(String str) =>
    List<StateModel>.from(json.decode(str).map((x) => StateModel.fromJson(x)));

String stateModelToJson(List<StateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateModel {
  StateModel({
    required this.stateId,
    required this.stateName,
    required this.subState,
  });

  String stateId;
  String stateName;
  List<SubState> subState;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        stateId: json["state_id"],
        stateName: json["state_name"],
        subState: List<SubState>.from(
            json["sub_state"].map((x) => SubState.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
        "sub_state": List<dynamic>.from(subState.map((x) => x.toJson())),
      };
}

class SubState {
  SubState({
    required this.id,
    required this.stateId,
    required this.name,
  });

  String id;
  String stateId;
  String name;

  factory SubState.fromJson(Map<String, dynamic> json) => SubState(
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
