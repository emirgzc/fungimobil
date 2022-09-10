import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/data/preferences_helper.dart';
import 'package:fungimobil/model/table_model.dart';

class TableRepository {
  final ApiClient _apiClient = locator<ApiClient>();
  final PreferencesHelper _preferencesHelper = locator<PreferencesHelper>();

  Future<Map<String, Column>> tableCreate(String tableName, {bool? tokenless}) async {
    try {
      String? token = (tokenless ?? false) ? '' : await _preferencesHelper.getUserToken();
      if (token == null) {
        throw CustomException.fromApiMessage('Kullanıcı verileri alınamadı!');
      }
      var result = await _apiClient.tableCreate(tableName: tableName, token: token);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}