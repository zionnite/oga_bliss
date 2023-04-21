// To parse this JSON data, do
//
//     final countSubscriptionItem = countSubscriptionItemFromJson(jsonString);

import 'dart:convert';

List<CountSubscriptionItem> countSubscriptionItemFromJson(String str) =>
    List<CountSubscriptionItem>.from(
        json.decode(str).map((x) => CountSubscriptionItem.fromJson(x)));

String countSubscriptionItemToJson(List<CountSubscriptionItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountSubscriptionItem {
  CountSubscriptionItem({
    this.successfulDebitting,
    this.countSubscriptionFailed,
    this.revenueAmount,
  });

  int? successfulDebitting;
  int? countSubscriptionFailed;
  int? revenueAmount;

  factory CountSubscriptionItem.fromJson(Map<String, dynamic> json) =>
      CountSubscriptionItem(
        successfulDebitting: json["successful_debitting"],
        countSubscriptionFailed: json["count_subscription_failed"],
        revenueAmount: json["revenue_amount"],
      );

  Map<String, dynamic> toJson() => {
        "successful_debitting": successfulDebitting,
        "count_subscription_failed": countSubscriptionFailed,
        "revenue_amount": revenueAmount,
      };
}
