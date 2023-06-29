// To parse this JSON data, do
//
//     final blissTransactionModel = blissTransactionModelFromJson(jsonString);

import 'dart:convert';

BlissTransactionModel blissTransactionModelFromJson(String str) =>
    BlissTransactionModel.fromJson(json.decode(str));

String blissTransactionModelToJson(BlissTransactionModel data) =>
    json.encode(data.toJson());

class BlissTransactionModel {
  String? status;
  List<MlmTransaction>? mlmTransaction;

  BlissTransactionModel({
    this.status,
    this.mlmTransaction,
  });

  factory BlissTransactionModel.fromJson(Map<String, dynamic> json) =>
      BlissTransactionModel(
        status: json["status"],
        mlmTransaction: json["mlm_transaction"] == null
            ? []
            : List<MlmTransaction>.from(json["mlm_transaction"]!
                .map((x) => MlmTransaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "mlm_transaction": mlmTransaction == null
            ? []
            : List<dynamic>.from(mlmTransaction!.map((x) => x.toJson())),
      };
}

class MlmTransaction {
  String? id;
  String? disUserId;
  String? disAmount;
  String? transType;
  String? description;
  String? refNo;
  String? disStatus;
  String? dateCreated;
  String? time;

  MlmTransaction({
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

  factory MlmTransaction.fromJson(Map<String, dynamic> json) => MlmTransaction(
        id: json["id"],
        disUserId: json["dis_user_id"],
        disAmount: json["dis_amount"],
        transType: json["trans_type"],
        description: json["description"],
        refNo: json["ref_no"],
        disStatus: json["dis_status"],
        dateCreated: json["date_created"],
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
        "date_created": dateCreated,
        "time": time,
      };
}
