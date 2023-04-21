// To parse this JSON data, do
//
//     final blissTransactionModel = blissTransactionModelFromJson(jsonString);

import 'dart:convert';

BlissTransactionModel blissTransactionModelFromJson(String str) =>
    BlissTransactionModel.fromJson(json.decode(str));

String blissTransactionModelToJson(BlissTransactionModel data) =>
    json.encode(data.toJson());

class BlissTransactionModel {
  BlissTransactionModel({
    this.status,
    this.transaction,
  });

  String? status;
  List<Transaction>? transaction;

  factory BlissTransactionModel.fromJson(Map<String, dynamic> json) =>
      BlissTransactionModel(
        status: json["status"],
        transaction: json["transaction"] == null
            ? []
            : List<Transaction>.from(
                json["transaction"]!.map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "transaction": transaction == null
            ? []
            : List<dynamic>.from(transaction!.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.id,
    this.disUserId,
    this.disAmount,
    this.transType,
    this.description,
    this.refNo,
    this.disStatus,
    this.dateCreated,
    this.time,
  });

  String? id;
  String? disUserId;
  String? disAmount;
  String? transType;
  String? description;
  String? refNo;
  String? disStatus;
  DateTime? dateCreated;
  String? time;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        disUserId: json["dis_user_id"],
        disAmount: json["dis_amount"],
        transType: json["trans_type"],
        description: json["description"],
        refNo: json["ref_no"],
        disStatus: json["dis_status"],
        dateCreated: json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dis_user_id": disUserId,
        "dis_amount": disAmount,
        "trans_type": transType,
        "description": description,
        "ref_no": refNo,
        "dis_status": disStatus,
        "date_created":
            "${dateCreated!.year.toString().padLeft(4, '0')}-${dateCreated!.month.toString().padLeft(2, '0')}-${dateCreated!.day.toString().padLeft(2, '0')}",
        "time": time,
      };
}
