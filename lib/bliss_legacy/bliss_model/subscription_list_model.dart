// To parse this JSON data, do
//
//     final subscriptionListModel = subscriptionListModelFromJson(jsonString);

import 'dart:convert';

SubscriptionListModel subscriptionListModelFromJson(String str) =>
    SubscriptionListModel.fromJson(json.decode(str));

String subscriptionListModelToJson(SubscriptionListModel data) =>
    json.encode(data.toJson());

class SubscriptionListModel {
  SubscriptionListModel({
    this.status,
    this.myPlanList,
  });

  String? status;
  List<MyPlanList>? myPlanList;

  factory SubscriptionListModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionListModel(
        status: json["status"],
        myPlanList: json["my_plan_list"] == null
            ? []
            : List<MyPlanList>.from(
                json["my_plan_list"]!.map((x) => MyPlanList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "my_plan_list": myPlanList == null
            ? []
            : List<dynamic>.from(myPlanList!.map((x) => x.toJson())),
      };
}

class MyPlanList {
  MyPlanList({
    this.id,
    this.userId,
    this.customerEmail,
    this.customerCode,
    this.subscriptionCode,
    this.emailToken,
    this.planName,
    this.planId,
    this.planCode,
    this.planDesc,
    this.planInterval,
    this.planAmount,
    this.planLimit,
    this.planImage,
    this.authBin,
    this.authLast4,
    this.authExpMonth,
    this.authExpYear,
    this.authCardType,
    this.subStartDate,
    this.subEndDate,
    this.status,
    this.requestCardUpdate,
    this.isSubscribe,
  });

  String? id;
  String? userId;
  String? customerEmail;
  String? customerCode;
  String? subscriptionCode;
  String? emailToken;
  String? planName;
  String? planId;
  String? planCode;
  dynamic planDesc;
  String? planInterval;
  String? planAmount;
  String? planLimit;
  String? planImage;
  String? authBin;
  String? authLast4;
  String? authExpMonth;
  String? authExpYear;
  String? authCardType;
  DateTime? subStartDate;
  String? subEndDate;
  String? status;
  String? requestCardUpdate;
  bool? isSubscribe;

  factory MyPlanList.fromJson(Map<String, dynamic> json) => MyPlanList(
        id: json["id"],
        userId: json["user_id"],
        customerEmail: json["customer_email"],
        customerCode: json["customer_code"],
        subscriptionCode: json["subscription_code"],
        emailToken: json["email_token"],
        planName: json["plan_name"],
        planId: json["plan_id"],
        planCode: json["plan_code"],
        planDesc: json["plan_desc"],
        planInterval: json["plan_interval"],
        planAmount: json["plan_amount"],
        planLimit: json["plan_limit"],
        planImage: json["plan_image"],
        authBin: json["auth_bin"],
        authLast4: json["auth_last4"],
        authExpMonth: json["auth_exp_month"],
        authExpYear: json["auth_exp_year"],
        authCardType: json["auth_card_type"],
        subStartDate: json["sub_start_date"] == null
            ? null
            : DateTime.parse(json["sub_start_date"]),
        subEndDate: json["sub_end_date"],
        status: json["status"],
        requestCardUpdate: json["request_card_update"],
        isSubscribe: json["is_subscribe"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "customer_email": customerEmail,
        "customer_code": customerCode,
        "subscription_code": subscriptionCode,
        "email_token": emailToken,
        "plan_name": planName,
        "plan_id": planId,
        "plan_code": planCode,
        "plan_desc": planDesc,
        "plan_interval": planInterval,
        "plan_amount": planAmount,
        "plan_limit": planLimit,
        "plan_image": planImage,
        "auth_bin": authBin,
        "auth_last4": authLast4,
        "auth_exp_month": authExpMonth,
        "auth_exp_year": authExpYear,
        "auth_card_type": authCardType,
        "sub_start_date": subStartDate?.toIso8601String(),
        "sub_end_date": subEndDate,
        "status": status,
        "request_card_update": requestCardUpdate,
        "is_subscribe": isSubscribe,
      };
}
