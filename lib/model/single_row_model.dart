// To parse this JSON data, do
//
//     final singleRowModel = singleRowModelFromJson(jsonString);

import 'dart:convert';

List<SingleRowModel> singleRowModelFromJson(String str) => List<SingleRowModel>.from(json.decode(str).map((x) => SingleRowModel.fromJson(x)));

String singleRowModelToJson(List<SingleRowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleRowModel 
{
    SingleRowModel(
    {
        required this.sts,
    });
    int sts;

    factory SingleRowModel.fromJson(Map<String, dynamic> json) => SingleRowModel(
        sts: json["sts"],
    );

    Map<String, dynamic> toJson() => {
        "sts": sts,
    };
}