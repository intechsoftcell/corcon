// To parse this JSON data, do
//
//     final boothDetailsModel = boothDetailsModelFromJson(jsonString);

import 'dart:convert';

BoothDetailsModel boothDetailsModelFromJson(String str) =>
    BoothDetailsModel.fromJson(json.decode(str));

String boothDetailsModelToJson(BoothDetailsModel data) =>
    json.encode(data.toJson());

class BoothDetailsModel {
  BoothDetailsModel({
    required this.dtqty,
  });

  List<Dtqty> dtqty;

  factory BoothDetailsModel.fromJson(Map<String, dynamic> json) =>
      BoothDetailsModel(
        dtqty: List<Dtqty>.from(json["dtqty"].map((x) => Dtqty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dtqty": List<dynamic>.from(dtqty.map((x) => x.toJson())),
      };
}

class Dtqty {
  Dtqty({
    required this.boothName,
    required this.sqMType,
  });

  String boothName;
  String sqMType;

  factory Dtqty.fromJson(Map<String, dynamic> json) => Dtqty(
        boothName: json["BoothName"],
        sqMType: json["SqMType"],
      );

  Map<String, dynamic> toJson() => {
        "BoothName": boothName,
        "SqMType": sqMType,
      };
}
