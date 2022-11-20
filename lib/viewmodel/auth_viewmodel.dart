import 'package:flutter/material.dart';

import '../constants/locator.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

enum AuthVMStatus { busy, free }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repository = locator<AuthRepository>();
  AuthVMStatus status = AuthVMStatus.free;

  Future login(String email, String password) async {
    status = AuthVMStatus.busy;
    notifyListeners();
    try {
      await _repository.login(email, password);
    } catch (e) {
      rethrow;
    } finally {
      status = AuthVMStatus.free;
      notifyListeners();
    }
  }

  Future register(Map<String, dynamic> data) async {
    status = AuthVMStatus.busy;
    notifyListeners();
    try {
      await _repository.register(data);
    } catch (e) {
      rethrow;
    } finally {
      status = AuthVMStatus.free;
      notifyListeners();
    }
  }

  Future forgetPasswordSendOtp(String email) async {
    status = AuthVMStatus.busy;
    notifyListeners();
    try {
      await _repository.forgetPasswordSendOtp(email);
    } catch (e) {
      rethrow;
    } finally {
      status = AuthVMStatus.free;
      notifyListeners();
    }
  }

  Future changePassword(String email, String pin, String newPassword) async {
    status = AuthVMStatus.busy;
    notifyListeners();
    try {
      await _repository.changePassword(email, pin, newPassword);
    } catch (e) {
      rethrow;
    } finally {
      status = AuthVMStatus.free;
      notifyListeners();
    }
  }

  Future<bool> isUserExists() async {
    try {
      final result = await _repository.isUserExists();
      return result;
    } catch (e) {
      rethrow;
    } finally {
      // notifyListeners();
    }
  }

  Future<UserModel?> getUserInfoFromLocale() async {
    try {
      final result = await _repository.getUserInfoFromLocale();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserInfoFromApi({String? token}) async {
    try {
      final result = await _repository.getUserInfoFromApi(token: token);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> syncLocaleUserInfo() async {
    try {
      final result = await _repository.saveUserInfo();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  //
  // Future<bool> isUserExistsWithApi() async {
  //   try {
  //     final result = await _repository.isUserExistsWithApi();
  //     return result;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<bool> signOut() async {
    try {
      return await _repository.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
