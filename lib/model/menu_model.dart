// To parse this JSON data, do
//
//     final menuModel = menuModelFromJson(jsonString);

import 'dart:convert';

class MenuModel {
  MenuModel({
    this.tableName,
    this.displayName,
    this.icon,
    this.status,
  });

  final String? tableName;
  final String? displayName;
  final String? icon;
  final String? status;

  factory MenuModel.fromRawJson(String str) => MenuModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    tableName: json["table_name"],
    displayName: json["display_name"],
    icon: json["icon"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "table_name": tableName,
    "display_name": displayName,
    "icon": icon,
    "status": status,
  };
}
