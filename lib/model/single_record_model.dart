// To parse this JSON data, do
//
//     final singleRecordModel = singleRecordModelFromJson(jsonString);

import 'dart:convert';

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
    columns: json["columns"] == null ? null : Map<String, Column>.from(json['columns']),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "columns": columns,
    "status": status,
  };
}

class Column {
  Column({
    this.name,
    this.display,
    this.type,
    this.length,
    this.aboutNull,
    this.aboutDefault,
    this.privileges,
    this.key,
  });

  final String? name;
  final String? display;
  final String? type;
  final String? length;
  final String? aboutNull;
  final String? aboutDefault;
  final String? privileges;
  final String? key;

  factory Column.fromRawJson(String str) => Column.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Column.fromJson(Map<String, dynamic> json) => Column(
    name: json["name"],
    display: json["display"],
    type: json["type"],
    length: json["length"],
    aboutNull: json["null"],
    aboutDefault: json["default"],
    privileges: json["privileges"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "display": display,
    "type": type,
    "length": length,
    "null": aboutNull,
    "default": aboutDefault,
    "privileges": privileges,
    "key": key,
  };
}
