// To parse this JSON data, do
//
//     final singleRowLoginModel = singleRowLoginModelFromJson(jsonString);

import 'dart:convert';

SingleRowLoginModel singleRowLoginModelFromJson(String str) => SingleRowLoginModel.fromJson(json.decode(str));

String singleRowLoginModelToJson(SingleRowLoginModel data) => json.encode(data.toJson());

class SingleRowLoginModel {
  SingleRowLoginModel({
    required this.userDetails,
  });

  List<UserDetail> userDetails;

  factory SingleRowLoginModel.fromJson(Map<String, dynamic> json) => SingleRowLoginModel(
    userDetails: List<UserDetail>.from(json["userDetails"].map((x) => UserDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userDetails": List<dynamic>.from(userDetails.map((x) => x.toJson())),
  };
}

class UserDetail {
  UserDetail({
    required this.sts,
    required this.name,
    required this.regId,
    required this.email,
  });

  int sts;
  String name;
  String regId;
  String email;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    sts: json["sts"],
    name: json["name"],
    regId: json["regId"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "sts": sts,
    "name": name,
    "regId": regId,
    "Email": email,
  };
}
