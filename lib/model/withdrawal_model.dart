// To parse this JSON data, do
//
//     final withdrawalModel = withdrawalModelFromJson(jsonString);

import 'dart:convert';

WithdrawalModel withdrawalModelFromJson(String str) =>
    WithdrawalModel.fromJson(json.decode(str));

String withdrawalModelToJson(WithdrawalModel data) =>
    json.encode(data.toJson());

class WithdrawalModel {
  String? status;
  List<Withdrawal>? withdrawal;

  WithdrawalModel({
    this.status,
    this.withdrawal,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalModel(
        status: json["status"],
        withdrawal: json["withdrawal"] == null
            ? []
            : List<Withdrawal>.from(
                json["withdrawal"]!.map((x) => Withdrawal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "withdrawal": withdrawal == null
            ? []
            : List<dynamic>.from(withdrawal!.map((x) => x.toJson())),
      };
}

class Withdrawal {
  String? id;
  String? disUserId;
  String? amount;
  DateTime? dateCreated;
  String? day;
  String? month;
  String? year;
  String? time;
  String? disStatus;
  String? grantedBy;
  String? disUserFullName;
  String? disUserName;
  String? disUserImage;
  String? paidStatus;

  Withdrawal({
    this.id,
    this.disUserId,
    this.amount,
    this.dateCreated,
    this.day,
    this.month,
    this.year,
    this.time,
    this.disStatus,
    this.grantedBy,
    this.disUserFullName,
    this.disUserName,
    this.disUserImage,
    this.paidStatus,
  });

  factory Withdrawal.fromJson(Map<String, dynamic> json) => Withdrawal(
        id: json["id"],
        disUserId: json["dis_user_id"],
        amount: json["amount"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        day: json["day"],
        month: json["month"],
        year: json["year"],
        time: json["time"],
        disStatus: json["dis_status"],
        grantedBy: json["granted_by"],
        disUserFullName: json["dis_user_full_name"],
        disUserName: json["dis_user_name"],
        disUserImage: json["dis_user_image"],
        paidStatus: json["paid_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_user_id": disUserId,
        "amount": amount,
        "date_created":
            "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
        "day": day,
        "month": month,
        "year": year,
        "time": time,
        "dis_status": disStatus,
        "granted_by": grantedBy,
        "dis_user_full_name": disUserFullName,
        "dis_user_name": disUserName,
        "dis_user_image": disUserImage,
        "paid_status": paidStatus,
      };
}
