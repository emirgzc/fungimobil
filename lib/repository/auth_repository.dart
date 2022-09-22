import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/data/preferences_helper.dart';
import 'package:fungimobil/model/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient = locator<ApiClient>();
  final PreferencesHelper _preferencesHelper = locator<PreferencesHelper>();

  Future login(String email, String password) async {
    try {
      String token = await _apiClient.login(email, password);
      bool result = await _preferencesHelper.setUserToken(token);
      if (!result) {
        throw CustomException.fromApiMessage('Kullanıcı verileri kaydedilemedi!');
      }
      result = await saveUserInfo();
      if (!result) {
        throw CustomException.fromApiMessage('Kullanıcı verileri kaydedilemedi!');
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

  Future forgetPasswordSendOtp(String email) async {
    try {
      await _apiClient.forgetPasswordSendOtp(email);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future changePassword(String email, String pin, String newPassword) async {
    try {
      await _apiClient.changePassword(email, pin, newPassword);
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
      String? token = await _preferencesHelper.getUserToken();

      if (token == null) {
        throw LoggedUserNotFoundException();
      }

      UserModel usermodel = await _apiClient.fetchProfile(token: token);
      return await _preferencesHelper.setUserInfo(usermodel);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserInfoFromLocale() async {
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

  Future<UserModel> getUserInfoFromApi({String? token}) async {
    try {
      String? token = await _preferencesHelper.getUserToken();
      if (token == null || token.isEmpty) {
        throw LoggedUserNotFoundException();
      }
      UserModel userModel = await _apiClient.fetchProfile(token: token);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      return await _preferencesHelper.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
