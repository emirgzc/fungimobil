import 'dart:convert';

import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/model/menu_model.dart';
import 'package:fungimobil/model/table_model.dart';

import '../constants/locator.dart';
import '../constants/table_util.dart';
import '../data/api_client.dart';
import '../data/preferences_helper.dart';

class ConfigRepository {
  final ApiClient _apiClient = locator<ApiClient>();
  final PreferencesHelper _preferencesHelper = locator<PreferencesHelper>();

  static const String menuKey = 'menu';

  Future<bool> saveMenu() async {
    try {
      String token = await _preferencesHelper.getUserToken() ?? '';
      TableModel tableModel = await _apiClient.fetchTable(tableName: TableName.Menu.name, token: token, page: 1, limit: 100, filter: {'status': 1});
      if (tableModel.data == null) {
        throw CustomException.fromApiMessage('Menü verileri getirilemedi. Lütfen internet bağlantınızı kontrol edip tekrar deneyiniz.');
      }
      return await _preferencesHelper.setStringData(menuKey, jsonEncode(tableModel.data));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MenuModel>> getMenu() async {
    try {
      String? result = await _preferencesHelper.getStringData(menuKey);
      if (result == null) {
        throw CustomException.fromApiMessage('Kayıtlı menü verileri getirilemedi. Lütfen daha sonra tekrar deneyiniz.');
      }
      List<MenuModel> menuList = (jsonDecode(result) as List).map((e) => MenuModel.fromJson(e as Map<String, dynamic>)).toList();
      return menuList;
    } catch (e) {
      rethrow;
    }
  }
}