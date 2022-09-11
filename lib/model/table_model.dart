import 'dart:convert';

// class TableModel {
//   TableModel({
//     required this.tableInfo,
//     required this.records,
//     required this.collectiveInfos,
//     required this.columns,
//     required this.queryColumns,
//     required this.pages,
//     required this.allRecordsCount,
//   });
//
//   final List<Map<String, dynamic>?>? records;
//   final dynamic collectiveInfos;
//   final Map<String, Column?>? columns;
//   final Map<String, Column?>? queryColumns;
//   final int? pages;
//   final int? allRecordsCount;
//
//   factory TableModel.fromRawJson(String str) => TableModel.fromJson(
//         json.decode(str),
//       );
//
//   String toRawJson() => json.encode(toJson());
//
//   factory TableModel.fromJson(
//     Map<String, dynamic> json,
//   ) =>
//       TableModel(
//         tableInfo: json["table_info"] == null ? null : TableInfo.fromJson(json["table_info"]),
//         records: json["records"] == null ? null : List<Map<String, dynamic>>.from(json["records"]),
//         collectiveInfos: (json["collectiveInfos"] is Map) ? json["collectiveInfos"] : {},
//         columns: json["columns"] == null
//             ? null
//             : Map.from(json["columns"])
//                 .map((k, v) => MapEntry<String, Column?>(k, v == null ? null : Column.fromJson(v))),
//         queryColumns: json["query_columns"] == null
//             ? null
//             : Map.from(json["query_columns"])
//                 .map((k, v) => MapEntry<String, Column?>(k, v == null ? null : Column.fromJson(v))),
//         pages: json["pages"],
//         allRecordsCount: json["all_records_count"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "table_info": tableInfo == null ? null : tableInfo!.toJson(),
//         "records": records == null ? null : List<dynamic>.from(records!),
//         "collectiveInfos": collectiveInfos,
//         "columns": columns == null ? null : Map.from(columns!).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
//         "query_columns": queryColumns == null
//             ? null
//             : Map.from(queryColumns!).map((k, v) => MapEntry<String, dynamic>(k, v?.toJson())),
//         "pages": pages,
//         "all_records_count": allRecordsCount,
//       };
//
//   @override
//   String toString() {
//     return 'TableModel{tableInfo: $tableInfo, records: $records, collectiveInfos: $collectiveInfos, columns: $columns, queryColumns: $queryColumns, pages: $pages, allRecordsCount: $allRecordsCount}';
//   }
// }

class TableModel {
  TableModel({
    required this.data,
    required this.columns,
    required this.page,
    required this.count,
    required this.status,
  });

  final List<Map<String, dynamic>>? data;
  final Map<String, Column>? columns;
  final int? page;
  final int? count;
  final String? status;

  factory TableModel.fromRawJson(String str) => TableModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        data: json["data"] == null
            ? null
            : List<Map<String, dynamic>>.from(json["data"].map((x) => x as Map<String, dynamic>)),
        columns: json["columns"] == null
            ? null
            : Map.from(json["columns"]).map((k, v) => MapEntry<String, Column>(k, Column.fromJson(v))),
        page: json["page"],
        count: json["count"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toString(),
        "columns": columns == null ? null : Map.from(columns!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "page": page,
        "count": count,
        "status": status,
      };
}

class Column {
  Column({
    required this.name,
    required this.display,
    required this.type,
    required this.length,
    required this.columnNull,
    required this.columnDefault,
    required this.privileges,
    required this.key,
  });

  final String? name;
  final String? display;
  final String? type;
  final String? length;
  final String? columnNull;
  final String? columnDefault;
  final String? privileges;
  final String? key;

  factory Column.fromRawJson(String str) => Column.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Column.fromJson(Map<String, dynamic> json) => Column(
        name: json["name"],
        display: json["display"],
        type: json["type"],
        length: json["length"],
        columnNull: json["null"],
        columnDefault: json["default"],
        privileges: json["privileges"],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "display": display,
        "type": type,
        "length": length,
        "null": columnNull,
        "default": columnDefault,
        "privileges": privileges,
        "key": key,
      };
}

// class Column {
//   Column({
//     required this.id,
//     required this.name,
//     required this.displayName,
//     required this.tableName,
//     required this.guiTypeName,
//     this.columnTableRelationId,
//     this.srid,
//     this.columnDefault,
//     this.relation,
//     this.eSign,
//     this.columnInfo,
//   });
//
//   final int? id;
//   final String? name;
//   final String? displayName;
//   final dynamic tableName;
//   final String? guiTypeName;
//   final int? columnTableRelationId;
//   final dynamic srid;
//   final dynamic columnDefault;
//   final Relation? relation;
//   final bool? eSign;
//   final dynamic columnInfo;
//
//   factory Column.fromRawJson(String str) => Column.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Column.fromJson(Map<String, dynamic> json) => Column(
//         id: json["id"],
//         name: json["name"],
//         displayName: json["display_name"],
//         tableName: json["table_name"],
//         guiTypeName: json["gui_type_name"],
//         columnTableRelationId: json["column_table_relation_id"],
//         srid: json["srid"],
//         columnDefault: json["default"],
//         relation: json["relation"] == null ? null : Relation.fromJson(json["relation"]),
//         eSign: json["e_sign"],
//         columnInfo: json["column_info"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "display_name": displayName,
//         "table_name": tableName,
//         "gui_type_name": guiTypeName,
//         "column_table_relation_id": columnTableRelationId,
//         "srid": srid,
//         "default": columnDefault,
//         "relation": relation == null ? null : relation!.toJson(),
//         "e_sign": eSign,
//         "column_info": columnInfo,
//       };
// }
//
// class Relation {
//   Relation({
//     required this.tableName,
//     required this.sourceColumnName,
//     required this.displayColumnName,
//   });
//
//   final String? tableName;
//   final dynamic sourceColumnName;
//   final dynamic displayColumnName;
//
//   factory Relation.fromRawJson(String str) => Relation.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Relation.fromJson(Map<String, dynamic> json) => Relation(
//         tableName: json["table_name"],
//         sourceColumnName: json["source_column_name"],
//         displayColumnName: json["display_column_name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "table_name": tableName,
//         "source_column_name": sourceColumnName,
//         "display_column_name": displayColumnName,
//       };
// }
//
// class TableInfo {
//   TableInfo({
//     required this.name,
//     required this.displayName,
//     required this.upTable,
//     required this.eSign,
//   });
//
//   final String? name;
//   final String? displayName;
//   final bool? upTable;
//   final bool? eSign;
//
//   factory TableInfo.fromRawJson(String str) => TableInfo.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory TableInfo.fromJson(Map<String, dynamic> json) => TableInfo(
//         name: json["name"],
//         displayName: json["display_name"],
//         upTable: json["up_table"],
//         eSign: json["e_sign"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "display_name": displayName,
//         "up_table": upTable,
//         "e_sign": eSign,
//       };
// }
