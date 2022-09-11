import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/data/preferences_helper.dart';
import 'package:fungimobil/model/single_record_model.dart';
import 'package:fungimobil/model/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient = locator<ApiClient>();
  final PreferencesHelper _preferencesHelper = locator<PreferencesHelper>();

  Future login(String email, String password) async {
    try {
      String token = await _apiClient.login(email, password);
      bool result = await _preferencesHelper.setUserToken(token);
      if (!result) {
        throw CustomException.fromApiMessage('Kullanıcı verisi kaydedilemedi!');
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future register(Map<String, dynamic> data) async {
    try {
      await _apiClient.register(data);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserExists() async {
    try {
      String? token = await _preferencesHelper.getUserToken();
      return !(token == null || token.isEmpty);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveUserInfo() async {
    try {
      int? userId = await _preferencesHelper.getUserId();
      String? token = await _preferencesHelper.getUserToken();

      if (userId == null || token == null) {
        throw LoggedUserNotFoundException();
      }

      SingleRecordModel recordModel =
          await _apiClient.fetchRecord(tableName: TableName.users.name, id: userId, token: token, isUserDb: true);

      if (recordModel.data == null) {
        throw LoggedUserNotFoundException();
      }

      UserModel user = UserModel.fromJson(recordModel.data!);
      return await _preferencesHelper.setUserInfo(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserInfo() async {
    try {
      UserModel? userModel = await _preferencesHelper.getUserInfo();
      if (userModel == null) {
        throw CustomException.fromApiMessage('Kayıtlı kullanıcı verileri getirilemedi');
      }
      return userModel;
    } catch (e) {
      rethrow;
    }
  }
}
