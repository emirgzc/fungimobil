// To parse this JSON data, do
//
//     final singleRecordModel = singleRecordModelFromJson(jsonString);

import 'dart:convert';

import 'table_model.dart';

class SingleRecordModel {
  SingleRecordModel({
    this.data,
    this.columns,
    this.status,
  });

  final Map<String, dynamic>? data;
  final Map<String, Column>? columns;
  final String? status;

  factory SingleRecordModel.fromRawJson(String str) => SingleRecordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SingleRecordModel.fromJson(Map<String, dynamic> json) => SingleRecordModel(
    data: json['data'] == null ? null : Map<String, dynamic>.from(json['data']),
    columns: json["columns"] == null
        ? null
        : Map.from(json["columns"]).map((k, v) => MapEntry<String, Column>(k, Column.fromJson(v))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "columns": columns,
    "status": status,
  };
}

