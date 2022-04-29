// To parse this JSON data, do
//
//     final symposiaModel = symposiaModelFromJson(jsonString);

import 'dart:convert';

SymposiaModel symposiaModelFromJson(String str) =>
    SymposiaModel.fromJson(json.decode(str));

String symposiaModelToJson(SymposiaModel data) => json.encode(data.toJson());

class SymposiaModel {
  SymposiaModel({
    required this.dtqty,
  });

  List<Dtqty> dtqty;

  factory SymposiaModel.fromJson(Map<String, dynamic> json) => SymposiaModel(
        dtqty: List<Dtqty>.from(json["dtqty"].map((x) => Dtqty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dtqty": List<dynamic>.from(dtqty.map((x) => x.toJson())),
      };
}

class Dtqty {
  Dtqty({
    required this.symposiaName,
  });

  String symposiaName;

  factory Dtqty.fromJson(Map<String, dynamic> json) => Dtqty(
        symposiaName: json["Symposia_Name"],
      );

  Map<String, dynamic> toJson() => {
        "Symposia_Name": symposiaName,
      };
}
