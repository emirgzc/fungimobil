import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/data/preferences_helper.dart';

class AuthRepository {
  final ApiClient _apiClient = locator<ApiClient>();
  final PreferencesHelper _preferencesHelper = locator<PreferencesHelper>();

  Future login(String email, String password) async {
    try {
      String token = await _apiClient.login(email, password);
      bool result = await _preferencesHelper.setUserToken(token);
      if (!result){
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
      if (token == null || token.isEmpty){
        throw Exception();
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }
}