// To parse this JSON data, do
//
//     final viewPaperModel = viewPaperModelFromJson(jsonString);

import 'dart:convert';

ViewPaperModel viewPaperModelFromJson(String str) =>
    ViewPaperModel.fromJson(json.decode(str));

String viewPaperModelToJson(ViewPaperModel data) => json.encode(data.toJson());

class ViewPaperModel {
  ViewPaperModel({
    required this.dtqty,
  });

  List<Dtqty> dtqty;

  factory ViewPaperModel.fromJson(Map<String, dynamic> json) => ViewPaperModel(
        dtqty: List<Dtqty>.from(json["dtqty"].map((x) => Dtqty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dtqty": List<dynamic>.from(dtqty.map((x) => x.toJson())),
      };
}

class Dtqty {
  Dtqty({
    required this.iaf,
    required this.paperName,
    required this.uploadedFile,
    required this.status,
    required this.uploadedBy,
    required this.uploadedDate,
    required this.empCode,
    required this.id,
    required this.emailId,
    required this.type,
  });

  String iaf;
  String paperName;
  String uploadedFile;
  String status;
  String uploadedBy;
  DateTime uploadedDate;
  String empCode;
  String id;
  String emailId;
  String type;

  factory Dtqty.fromJson(Map<String, dynamic> json) => Dtqty(
        iaf: json["IAF"],
        paperName: json["PaperName"],
        uploadedFile: json["UploadedFile"],
        status: json["Status"],
        uploadedBy: json["UploadedBy"],
        uploadedDate: DateTime.parse(json["UploadedDate"]),
        empCode: json["EmpCode"],
        id: json["Id"],
        emailId: json["EmailId"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "IAF": iaf,
        "PaperName": paperName,
        "UploadedFile": uploadedFile,
        "Status": status,
        "UploadedBy": uploadedBy,
        "UploadedDate": uploadedDate.toIso8601String(),
        "EmpCode": empCode,
        "Id": id,
        "EmailId": emailId,
        "Type": type,
      };
}
