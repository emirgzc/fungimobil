import 'package:flutter/material.dart';

import '../constants/locator.dart';
import '../repository/table_repository.dart';
import '../model/table_model.dart' as table;

enum TableVMStatus { busy, free }

class TableViewModel extends ChangeNotifier {
  final TableRepository _repository = locator<TableRepository>();
  TableVMStatus status = TableVMStatus.free;

  Future<Map<String, table.Column>> tableCreate(String tableName) async {
    status = TableVMStatus.busy;
    notifyListeners();
    try {
      var data = await _repository.tableCreate(tableName);
      return data;
    } catch (e) {
      rethrow;
    } finally {
      status = TableVMStatus.free;
      notifyListeners();
    }
  }
}
