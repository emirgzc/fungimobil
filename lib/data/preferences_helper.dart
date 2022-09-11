import 'package:flutter/material.dart';
import 'package:fungimobil/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static SharedPreferences? _preferences;

  static const String _tokenKey = 'user_token';
  static const String _userId = 'user_id';
  static const String _userInfo = 'user_info';

  Future _initPreferences() async {
    try {
      _preferences ??= await SharedPreferences.getInstance();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setUserToken(String token) async {
    try {
      await _initPreferences();
      return await _preferences!.setString(_tokenKey, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getUserToken() async {
    try {
      await _initPreferences();
      return _preferences!.getString(_tokenKey);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setUserId(int id) async {
    try {
      await _initPreferences();
      return await _preferences!.setInt(_userId, id);
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> getUserId() async {
    try {
      await _initPreferences();
      int? userId = _preferences!.getInt(_userId);
      if (userId == null) return null;
      return userId;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setUserInfo(UserModel user) async {
    try {
      await _initPreferences();
      String rawFormat = user.toRawJson();
      return await _preferences!.setString(_userInfo, rawFormat);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUserInfo() async {
    try {
      await _initPreferences();
      String? rawFormat = _preferences!.getString(_userInfo);
      if (rawFormat == null) return null;
      return UserModel.fromRawJson(rawFormat);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      await _initPreferences();
      debugPrint('signOut');
      final result = await _preferences!.setString(_tokenKey, '');
      if (!result) {
        throw Exception();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
