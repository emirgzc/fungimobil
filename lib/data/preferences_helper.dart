import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static SharedPreferences? _preferences;

  static const String _tokenKey = 'user_token';

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
