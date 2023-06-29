// To parse this JSON data, do
//
//     final joinSubscription = joinSubscriptionFromJson(jsonString);

import 'dart:convert';

List<JoinSubscription> joinSubscriptionFromJson(String str) =>
    List<JoinSubscription>.from(
        json.decode(str).map((x) => JoinSubscription.fromJson(x)));

String joinSubscriptionToJson(List<JoinSubscription> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JoinSubscription {
  JoinSubscription({
    this.status,
    this.link,
  });

  String? status;
  String? link;

  factory JoinSubscription.fromJson(Map<String, dynamic> json) =>
      JoinSubscription(
        status: json["status"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "link": link,
      };
}
