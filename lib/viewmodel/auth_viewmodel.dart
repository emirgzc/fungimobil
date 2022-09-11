import 'package:flutter/material.dart';

import '../constants/locator.dart';
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
      // final result = await _repository.signOut();
      // return result;
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
