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
    required int page,
    required int limit,
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

  Future<Map<String, Column>> tableCreate(String tableName, {bool isUserDb = false}) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      var result = await _apiClient.tableCreate(tableName: tableName, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<SingleRecordModel> fetchRecord(String tableName, int id, {bool isUserDb = false}) async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      var result = await _apiClient.fetchRecord(tableName: tableName, id: id, token: token, isUserDb: isUserDb);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
