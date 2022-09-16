import 'package:flutter/material.dart';
import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/model/single_record_model.dart';

import '../constants/locator.dart';
import '../repository/table_repository.dart';
import '../model/table_model.dart' as table;

enum TableVMStatus { busy, free }

class TableViewModel extends ChangeNotifier {
  final TableRepository _repository = locator<TableRepository>();
  TableVMStatus status = TableVMStatus.free;

  table.TableModel? _tableModel;
  Map<String, dynamic>? _filter;
  int? _page;
  int? _limit;

  Future<table.TableModel?> listenTable() async {
    return _tableModel;
  }

  table.TableModel? get tableModel => _tableModel;

  Map<String, dynamic>? get filter => _filter;

  int get page => _page ?? 1;

  int get limit => _limit ?? 10;

  void changePage(int newPage) {
    _page = newPage;
    notifyListeners();
  }

  Future<table.TableModel> fetchTable({
      required String tableName,
      required int page,
      required int limit,
        Map filter = const {},
      }) async {
    try {
      _tableModel = await _repository.fetchTable(
        tableName: tableName,
        page: page,
        limit: limit,
        filter: filter,
      );
      return _tableModel!;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<table.TableModel> fetchTempTable({
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

  Future<table.TableModel> changePageTableData({
    required String tableName,
    required int page,
    required int limit,
    Map filter = const {},}) async {
    try {
      if (_tableModel == null) {
        throw UnknownException();
      }
      final data = await _repository.fetchTable(
        tableName: tableName,
        page: page,
        limit: limit,
        filter: filter,
      );
      table.TableModel tempTableModel = table.TableModel.of(_tableModel!);
      tempTableModel.data!.addAll(data.data!);

      tempTableModel.page = data.page;
      _tableModel = tempTableModel;

      _page = page;

      return _tableModel!;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
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
