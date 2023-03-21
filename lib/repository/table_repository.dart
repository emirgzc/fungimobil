import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/data/preferences_helper.dart';
import 'package:fungimobil/model/table_model.dart';

import '../model/single_record_model.dart';

class TableRepository {
  final ApiClient _apiClient = locator<ApiClient>();
  final PreferencesHelper _preferencesHelper = locator<PreferencesHelper>();

  Future<TableModel> fetchTable({
    required String tableName,
    required int? page,
    required int? limit,
    Map filter = const {},
  }) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';

      TableModel? tableModel = await _apiClient.fetchTable(
        tableName: tableName,
        token: token,
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
      String token = await _preferencesHelper.getUserToken() ?? '';

      int count = await _apiClient.fetchTableCount(
        tableName: tableName,
        token: token,
        filter: filter,
      );
      return count;
    } catch (e) {
      rethrow;
    }
  }

  Future<SingleRecordModel> fetchRecord({required String tableName, required int id, bool isUserDb = false}) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      var result = await _apiClient.fetchRecord(tableName: tableName, id: id, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, Column>> tableCreate({required String tableName, bool isUserDb = false}) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      var result = await _apiClient.tableCreate(tableName: tableName, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future tableStore(
      {required String tableName, required Map<String, dynamic> data, bool isUserDb = false}) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      var result = await _apiClient.storeRecord(tableName: tableName, data: data, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> tableEdit({required String tableName, required int id, bool isUserDb = false}) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      var result = await _apiClient.editRecord(tableName: tableName, id: id, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future tableUpdate(
      {required String tableName, required Map<String, dynamic> data, required int id, bool isUserDb = false}) async {
    try {
      String token = (await _preferencesHelper.getUserToken()) ?? '';
      var result =
          await _apiClient.updateRecord(tableName: tableName, data: data, id: id, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
