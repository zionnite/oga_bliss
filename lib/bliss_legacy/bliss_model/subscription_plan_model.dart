// To parse this JSON data, do
//
//     final subscriptionPlanModel = subscriptionPlanModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPlanModel subscriptionPlanModelFromJson(String str) =>
    SubscriptionPlanModel.fromJson(json.decode(str));

String subscriptionPlanModelToJson(SubscriptionPlanModel data) =>
    json.encode(data.toJson());

class SubscriptionPlanModel {
  SubscriptionPlanModel({
    this.status,
    this.plans,
  });

  String? status;
  List<Plan>? plans;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlanModel(
        status: json["status"],
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
      };
}

class Plan {
  Plan({
    this.disId,
    this.planName,
    this.planId,
    this.planCode,
    this.planDesc,
    this.planInterval,
    this.planAmount,
    this.planLimit,
    this.locationId,
    this.locationName,
    this.status,
    this.planImage,
    this.isSubscribe,
    this.planType,
    this.expectedAmount,
  });

  String? disId;
  String? planName;
  String? planId;
  String? planCode;
  String? planDesc;
  String? planInterval;
  String? planAmount;
  String? planLimit;
  String? locationId;
  String? locationName;
  String? status;
  String? planImage;
  bool? isSubscribe;
  String? planType;
  String? expectedAmount;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        disId: json["dis_id"],
        planName: json["plan_name"],
        planId: json["plan_id"],
        planCode: json["plan_code"],
        planDesc: json["plan_desc"],
        planInterval: json["plan_interval"],
        planAmount: json["plan_amount"],
        planLimit: json["plan_limit"],
        locationId: json["location_id"],
        locationName: json["location_name"],
        status: json["status"],
        planImage: json["plan_image"],
        isSubscribe: json["is_subscribe"],
        planType: json["plan_type"],
        expectedAmount: json["expected_amount"],
      );

  Map<String, dynamic> toJson() => {
        "dis_id": disId,
        "plan_name": planName,
        "plan_id": planId,
        "plan_code": planCode,
        "plan_desc": planDesc,
        "plan_interval": planInterval,
        "plan_amount": planAmount,
        "plan_limit": planLimit,
        "location_id": locationId,
        "location_name": locationName,
        "status": status,
        "plan_image": planImage,
        "is_subscribe": isSubscribe,
        "plan_type": planType,
        "expected_amount": expectedAmount,
      };
}
