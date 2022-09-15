import 'package:flutter/material.dart';
import 'package:fungimobil/model/single_record_model.dart';

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

  Future<int> fetchTableCount({
      required String tableName,
        Map filter = const {},
      }) async {
    try {
      int count = await _repository.fetchTableCount(
        tableName: tableName,
        filter: filter,
      );
      return count;
    } catch (e) {
      rethrow;
    }
  }

  Future<SingleRecordModel> fetchRecord({required String tableName, required int id, bool isUserDb = false}) async {
    // status = TableVMStatus.busy;
    // notifyListeners();
    try {
      var data = await _repository.fetchRecord(tableName: tableName, id: id, isUserDb: isUserDb);
      return data;
    } catch (e) {
      rethrow;
    } finally {
      // status = TableVMStatus.free;
      // notifyListeners();
    }
  }

  Future<Map<String, table.Column>> tableCreate({required String tableName, bool isUserDb = false}) async {
    status = TableVMStatus.busy;
    notifyListeners();
    try {
      var result = await _repository.tableCreate(tableName: tableName, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    } finally {
      status = TableVMStatus.free;
      notifyListeners();
    }
  }

  Future tableStore({required String tableName, required Map<String, dynamic> data, bool isUserDb = false}) async {
    status = TableVMStatus.busy;
    notifyListeners();
    try {
      var result = await _repository.tableStore(tableName: tableName, data: data, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    } finally {
      status = TableVMStatus.free;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> tableEdit({required String tableName, required int id, bool isUserDb = false}) async {
    // status = TableVMStatus.busy;
    // notifyListeners();
    try {
      var result = await _repository.tableEdit(tableName: tableName, id: id, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }/* finally {
      status = TableVMStatus.free;
      notifyListeners();
    }*/
  }

  Future tableUpdate({required String tableName, required Map<String, dynamic> data, required int id, bool isUserDb = false}) async {
    status = TableVMStatus.busy;
    notifyListeners();
    try {
      var result = await _repository.tableUpdate(tableName: tableName, data: data, id: id, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    } finally {
      status = TableVMStatus.free;
      notifyListeners();
    }
  }
}
