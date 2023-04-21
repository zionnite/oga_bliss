// To parse this JSON data, do
//
//     final cardActivitiesListModel = cardActivitiesListModelFromJson(jsonString);

import 'dart:convert';

CardActivitiesListModel cardActivitiesListModelFromJson(String str) =>
    CardActivitiesListModel.fromJson(json.decode(str));

String cardActivitiesListModelToJson(CardActivitiesListModel data) =>
    json.encode(data.toJson());

class CardActivitiesListModel {
  CardActivitiesListModel({
    this.status,
    this.subscription,
  });

  String? status;
  List<Subscription>? subscription;

  factory CardActivitiesListModel.fromJson(Map<String, dynamic> json) =>
      CardActivitiesListModel(
        status: json["status"],
        subscription: json["subscription"] == null
            ? []
            : List<Subscription>.from(
                json["subscription"]!.map((x) => Subscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subscription": subscription == null
            ? []
            : List<dynamic>.from(subscription!.map((x) => x.toJson())),
      };
}

class Subscription {
  Subscription({
    this.id,
    this.userId,
    this.customerEmail,
    this.customerCode,
    this.planId,
    this.planCode,
    this.amount,
    this.paidDate,
    this.day,
    this.month,
    this.year,
    this.time,
    this.status,
    this.description,
  });

  String? id;
  String? userId;
  String? customerEmail;
  String? customerCode;
  String? planId;
  String? planCode;
  String? amount;
  String? paidDate;
  String? day;
  String? month;
  String? year;
  String? time;
  String? status;
  String? description;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        userId: json["user_id"],
        customerEmail: json["customer_email"],
        customerCode: json["customer_code"],
        planId: json["plan_id"],
        planCode: json["plan_code"],
        amount: json["amount"],
        paidDate: json["paid_date"],
        day: json["day"],
        month: json["month"],
        year: json["year"],
        time: json["time"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "customer_email": customerEmail,
        "customer_code": customerCode,
        "plan_id": planId,
        "plan_code": planCode,
        "amount": amount,
        "paid_date": paidDate,
        "day": day,
        "month": month,
        "year": year,
        "time": time,
        "status": status,
        "description": description,
      };
}
