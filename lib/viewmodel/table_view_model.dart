import 'package:flutter/material.dart';

import '../constants/locator.dart';
import '../repository/table_repository.dart';
import '../model/table_model.dart' as table;

enum TableVMStatus { busy, free }

class TableViewModel extends ChangeNotifier {
  final TableRepository _repository = locator<TableRepository>();
  TableVMStatus status = TableVMStatus.free;

  Future<table.TableModel> fetchTable({
      required String tableName,
      required int page,
      required int limit,
        Map filter = const {},
      }) async {
    try {
      table.TableModel tableModel = await _repository.fetchTable(
        tableName: tableName,
        page: page,
        limit: limit,
        filter: filter,
      );
      return tableModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, table.Column>> tableCreate(String tableName, {bool isUserDb = false}) async {
    status = TableVMStatus.busy;
    notifyListeners();
    try {
      var data = await _repository.tableCreate(tableName, isUserDb: isUserDb);
      return data;
    } catch (e) {
      rethrow;
    } finally {
      status = TableVMStatus.free;
      notifyListeners();
    }
  }
}
