// To parse this JSON data, do
//
//     final symposiaListModel = symposiaListModelFromJson(jsonString);

import 'dart:convert';

SymposiaListModel symposiaListModelFromJson(String str) => SymposiaListModel.fromJson(json.decode(str));

String symposiaListModelToJson(SymposiaListModel data) => json.encode(data.toJson());

class SymposiaListModel {
  SymposiaListModel({
    required this.dtqty,
  });

  List<Dtqty> dtqty;

  factory SymposiaListModel.fromJson(Map<String, dynamic> json) => SymposiaListModel(
    dtqty: List<Dtqty>.from(json["dtqty"].map((x) => Dtqty.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "dtqty": List<dynamic>.from(dtqty.map((x) => x.toJson())),
  };
}

class Dtqty {
  Dtqty({
    required this.symposiaName,
    required this.paperTitle,
  });

  String symposiaName;
  String paperTitle;

  factory Dtqty.fromJson(Map<String, dynamic> json) => Dtqty(
    symposiaName: json["Symposia_Name"],
    paperTitle: json["PaperTitle"],
  );

  Map<String, dynamic> toJson() => {
    "Symposia_Name": symposiaName,
    "PaperTitle": paperTitle,
  };
}
