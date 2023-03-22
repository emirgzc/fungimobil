import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fungimobil/model/single_record_model.dart';
import 'package:fungimobil/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../constants/exceptions.dart';
import '../model/table_model.dart' as table;

class ApiClient {
  final String _baseUrl = 'https://api.fungiturkey.org/api';
  final String _dbName = '/fungitu2_fungiturkey';
  final String _userDbName = '/fungitu2_Simple';
  final String _baseUrlWithDb = 'https://api.fungiturkey.org/api/fungitu2_fungiturkey';

  Future<String> login(String email, String password) async {
    try {
      debugPrint('Api Client -- Login');
      debugPrint('email: $email password: $password');

      Map<String, String> requestBody = {
        'email': email,
        'password': password,
      };

      String url = '$_baseUrl/login';

      debugPrint('api url ::: $url');
      log('$url params:$requestBody', name: 'API_SEND');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
        body: jsonEncode(requestBody),
      );
      debugPrint('response : ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode('{${response.body.split('{')[1]}');
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient login RESPONSE ::: ${response.body}');
        return json['token'];
      } else {
        debugPrint('ApiClient login ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future register(Map<String, dynamic> data) async {
    try {
      debugPrint('Api Client -- Register');

      String url = '$_baseUrl/register';
      debugPrint('ApiUrl: $url');

      log('$url params:$data', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
        body: jsonEncode(data),
      );

      debugPrint('response : ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      if (response.statusCode == 200) {
        debugPrint('ApiClient register RESPONSE ::: ${response.body}');
      } else {
        debugPrint('ApiClient register ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future forgetPasswordSendOtp(String email) async {
    try {
      debugPrint('Api Client -- forgetPasswordSendOtp');

      Map requestBody = {
        'email': email,
      };

      String url = '$_baseUrl/forget';
      debugPrint('ApiUrl: $url');
      log('$url params:$requestBody', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('response : ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient forgetPasswordSendOtp RESPONSE ::: ${response.body}');
      } else {
        debugPrint('ApiClient forgetPasswordSendOtp ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future changePassword(String email, String pin, String newPassword) async {
    try {
      debugPrint('Api Client -- changePassword');

      Map requestBody = {
        'email': email,
        'pin': pin,
        'password': newPassword,
      };

      String url = '$_baseUrl/forgetPassword';
      debugPrint('ApiUrl: $url');
      log('$url params:$requestBody}', name: 'API_SEND');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('response : ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient changePassword RESPONSE ::: ${response.body}');
      } else {
        debugPrint('ApiClient changePassword ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<table.TableModel> fetchTable({
    required String tableName,
    required String token,
    required int? page,
    required int? limit,
    required Map filter,
  }) async {
    try {
      filter = Map.of(filter);
      filter['status'] = 1;
      final Map<String, dynamic> requestBody = {
        if(page != null) 'page': page,
        if(limit != null) 'limit': limit,
        'filter': filter,
      };
      String url = '$_baseUrlWithDb/$tableName';
      debugPrint('apiUrl ::: $url');
      debugPrint('params : ${requestBody.entries.map((e) => '${e.key}: (${e.value.runtimeType}) ${e.value}')}');
      log('$url params:$requestBody', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Response ::: ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        table.TableModel tableModel = table.TableModel.fromJson(json);
        debugPrint('ApiClient fetchTable SUCCESS');
        return tableModel;
      } else {
        debugPrint('ApiClient fetchTable ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<int> fetchTableCount({
    required String tableName,
    required String token,
    required Map filter,
  }) async {
    try {
      filter = Map.of(filter);
      filter['status'] = 1;
      final Map<String, dynamic> requestBody = {
        'filter': filter,
      };
      String url = '$_baseUrlWithDb/$tableName/count';
      debugPrint('apiUrl ::: $url');
      debugPrint('params : $requestBody');

      log('$url params:$requestBody', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Response ::: ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json =
          response.body.startsWith('{') ? jsonDecode(response.body) : jsonDecode('{${response.body.split('{')[1]}');
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        return int.tryParse(json['data'].toString()) ?? 0;
      } else {
        debugPrint('ApiClient fetchTableCount ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<Map<String, table.Column>> tableCreate({
    required String tableName,
    required String token,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrl${isUserDb ? _userDbName : _dbName}/$tableName/create';
      debugPrint('apiUrl ::: $url');
      log('$url params:empty', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient tableCreate fulldata ::: ${jsonDecode(response.body)}');
        final columnsMap = (json['columns'] as Map);
        final columns = columnsMap.map((key, value) => MapEntry(key as String, table.Column.fromJson(value)));
        debugPrint('ApiClient tableCreate data ::: $columns');
        debugPrint('ApiClient tableCreate SUCCESS');
        return columns;
      } else {
        debugPrint('ApiClient tableCreate ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  /// Tamamlanmadı. Kontrol edilecek
  Future storeRecord({
    required String tableName,
    required String token,
    required Map<String, dynamic> data,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrl${isUserDb ? _userDbName : _dbName}/$tableName/store';
      debugPrint('apiUrl ::: $url');
      log('$url params:$data', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'token': token},
        body: jsonEncode(data),
      );

      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      // Map<String, dynamic> json = jsonDecode(response.body);
      // if (_isRequestHaveMessage(json)) {
      //   _throwError(json);
      // }

      if (response.statusCode == 200) {
        // debugPrint('ApiClient tableCreate fulldata ::: ${jsonDecode(response.body)}');
        // final columnsMap = (json['columns'] as Map);
        // final columns = columnsMap.map((key, value) => MapEntry(key as String, table.Column.fromJson(value)));
        // debugPrint('ApiClient tableCreate data ::: $columns');
        // debugPrint('ApiClient tableCreate SUCCESS');
        // return columns;
        debugPrint('ApiClient tableStore SUCCESS data:: $json');
        return;
      } else {
        debugPrint('ApiClient tableStore ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<Map<String, dynamic>> editRecord({
    required String tableName,
    required String token,
    required int id,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrl${isUserDb ? _userDbName : _dbName}/$tableName/$id/edit';
      debugPrint('apiUrl ::: $url');
      log('$url params:empty', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient tableCreate fulldata ::: ${jsonDecode(response.body)}');
        debugPrint('ApiClient tableCreate SUCCESS');
        return json;
      } else {
        debugPrint('ApiClient tableCreate ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future updateRecord({
    required String tableName,
    required String token,
    required Map<String, dynamic> data,
    required int id,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrl${isUserDb ? _userDbName : _dbName}/$tableName/$id/update';
      debugPrint('apiUrl ::: $url');
      log('$url params:$data', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'token': token},
        body: jsonEncode(data),
      );

      debugPrint('response body : ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        // debugPrint('ApiClient tableCreate fulldata ::: ${jsonDecode(response.body)}');
        // final columnsMap = (json['columns'] as Map);
        // final columns = columnsMap.map((key, value) => MapEntry(key as String, table.Column.fromJson(value)));
        // debugPrint('ApiClient tableCreate data ::: $columns');
        // debugPrint('ApiClient tableCreate SUCCESS');
        // return columns;
        debugPrint('ApiClient tableStore SUCCESS data:: $json');
        return;
      } else {
        debugPrint('ApiClient tableStore ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<SingleRecordModel> fetchRecord({
    required String tableName,
    required int id,
    required String token,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrl${isUserDb ? _userDbName : _dbName}/$tableName/$id/get';
      debugPrint('apiUrl ::: $url');
      log('$url params:empty', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      debugPrint('Response ::: ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        SingleRecordModel record = SingleRecordModel.fromJson(json);
        debugPrint('ApiClient fetchRecord SUCCESS');
        return record;
      } else {
        debugPrint('ApiClient fetchRecord ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<UserModel> fetchProfile({
    required String token,
  }) async {
    try {
      String url = '$_baseUrl/profile';
      debugPrint('apiUrl ::: $url');
      log('$url params:empty', name: 'API_SEND');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      debugPrint('Response ::: ${response.body}');
      var splitList = url.split('/');
      log(response.body, name: 'API_RESPONSE-${splitList[splitList.length - 2]}/${splitList[splitList.length - 1]}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(json['data']);
        debugPrint('ApiClient fetchProfile SUCCESS');
        return userModel;
      } else {
        debugPrint('ApiClient fetchProfile ERROR ::: ${response.body}');
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  bool _isRequestHaveMessage(Map json) {
    return json['message'] != null;
  }

  _throwError(Map json) {
    if (json['status'] == 'error' && json['message'] != null) {
      throw CustomException.fromApiMessage(json['message']);
    }
  }
}
