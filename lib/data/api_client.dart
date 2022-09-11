import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fungimobil/model/single_record_model.dart';
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

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
        body: jsonEncode(requestBody),
      );
      debugPrint('response : ${response.body}');

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
      debugPrint('data: $data');

      String url = '$_baseUrl/register';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
        body: jsonEncode(data),
      );
      debugPrint('response : ${response.body}');
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

  Future<table.TableModel> fetchTable({
    required String tableName,
    required String token,
    required int page,
    required int limit,
    required Map filter,
  }) async {
    try {
      filter = Map.of(filter);
      filter['status'] = 1;
      final Map<String, dynamic> requestBody = {
        'page': page,
        'limit': limit,
        'filter': filter,
      };
      String url = '$_baseUrl/fungitu2_fungiturkey/$tableName';
      debugPrint('apiUrl ::: $url');
      debugPrint('params : $requestBody');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('Response ::: ${response.body}');

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

  Future<Map<String, table.Column>> tableCreate({
    required String tableName,
    required String token,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrl${isUserDb ? _userDbName : _dbName}/$tableName/create';
      debugPrint('apiUrl ::: $url');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': '',
        },
      );

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

  Future<SingleRecordModel> fetchRecord({
    required String tableName,
    required int id,
    required String token,
    bool isUserDb = false,
  }) async {
    try {
      String url = '$_baseUrlWithDb/$tableName/$id/get';
      debugPrint('apiUrl ::: $url');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      debugPrint('Response ::: ${response.body}');

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

  // Future<Map<String, dynamic>?> fetchSelectData({
  //   required String token,
  //   required String tableName,
  //   required String columnName,
  //   required int page,
  //   required int limit,
  //   required String searchKey,
  //   String? upColumnName,
  //   dynamic upColumnData,
  // }) async {
  //   try {
  //     final Map<String, dynamic> requestBody = {
  //       'page': page,
  //       'limit': limit,
  //       'search': searchKey.isEmpty ? '***' : searchKey,
  //       if (upColumnName != null) 'upColumnName': upColumnName,
  //       if (upColumnData != null) 'upColumnData': upColumnData,
  //     };
  //     String url = '$_baseUrl/$token/tables/$tableName/getSelectColumnData/$columnName';
  //     debugPrint('apiUrl ::: $url');
  //     debugPrint('params : $requestBody');
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     if (_isRequestHaveMessage(json)) {
  //       _throwError(json);
  //     }
  //
  //     if (response.statusCode == 200) {
  //       debugPrint('ApiClient fetchSelectData SUCCESS : ${response.body}');
  //       return json;
  //     } else {
  //       debugPrint('ApiClient fetchSelectData params ::: $requestBody ERROR ::: ${response.body}');
  //       // throw Exception(response.body);
  //       throw ApiException();
  //     }
  //   } catch (e) {
  //     if (e is SocketException) throw ApiException();
  //     rethrow;
  //   }
  // }

  // Future<int> storeRecord({
  //   required String? token,
  //   required String tableName,
  //   required Map<String, dynamic> dataMap,
  //   bool tokenLess = false,
  //   bool blogServer = false,
  //   required Map<String, dynamic>? loggedUserInfo,
  // }) async {
  //   try {
  //     Map<String, dynamic> requestBody = Map.of(dataMap);
  //     if (!tokenLess) {
  //       if (loggedUserInfo == null) {
  //         throw ('LoggedUserInfo is null (api_client:storeRecord) tableName:$tableName');
  //       }
  //       final String columnSetId = loggedUserInfo['auths']['tables'][tableName]['creates'][0];
  //       requestBody['column_set_id'] = columnSetId;
  //     }
  //     String url = '${blogServer ? _blogServerBaseUrl : _baseUrl}${tokenLess ? '' : '/$token'}/tables/$tableName/store';
  //
  //     debugPrint('apiUrl ::: $url');
  //     debugPrint('params : $requestBody');
  //
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(requestBody),
  //     );
  //
  //     debugPrint('response.body: ${response.body}');
  //
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     if (_isRequestHaveMessage(json)) {
  //       _throwError(json);
  //     }
  //
  //     if (response.statusCode == 200) {
  //       debugPrint('ApiClient storeRecord SUCCESS : ${response.body}');
  //       final int? id = json['data']['id'] as int?;
  //       if (id == null) {
  //         debugPrint('ApiClient storeRecord id alınamadı : $json');
  //         throw Exception(response.body);
  //       }
  //       return id;
  //     } else {
  //       debugPrint('ApiClient storeRecord ERROR ::: ${response.body}');
  //       // throw Exception(response.body);
  //       throw ApiException();
  //     }
  //   } catch (e) {
  //     if (e is SocketException) throw ApiException();
  //     rethrow;
  //   }
  // }

  /*Future<Map<String, dynamic>?> tableEdit({
    required String tableName,
    required int id,
    required String token,
    required Map<String, dynamic> loggedUserInfo,
  }) async {
    try {
      final String columnSetId = loggedUserInfo['auths']['tables'][tableName]['edits'][0];
      final Map<String, dynamic> params = {
        'column_set_id': columnSetId,
      };
      final Map<String, dynamic> requestBody = {
        'params': jsonEncode(params),
      };
      String url = '$_baseUrl/$token/tables/$tableName/$id/edit';
      debugPrint('apiUrl ::: $url');
      debugPrint('params : $requestBody');
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient tableEdit SUCCESS');
        return json['data'];
      } else {
        debugPrint('ApiClient tableEdit ERROR ::: ${response.body}');
        // throw Exception(response.body);
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future<int?> updateRecord({
    required String token,
    required String tableName,
    required int id,
    required Map<String, dynamic> dataMap,
    required Map<String, dynamic> loggedUserInfo,
  }) async {
    try {
      final String columnSetId = loggedUserInfo['auths']['tables'][tableName]['edits'][0];
      final Map<String, dynamic> requestBody = Map.of(dataMap);
      requestBody['column_set_id'] = columnSetId;
      String url = '$_baseUrl/$token/tables/$tableName/$id/update';

      debugPrint('apiUrl ::: $url');
      debugPrint('params : ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      debugPrint('update response ::: ${response.body}');

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient updateRecord SUCCESS : ${response.body}');
        final int? id = json['data']['id'];
        return id;
      } else {
        debugPrint('ApiClient updateRecord ERROR ::: ${response.body}');
        // throw Exception(response.body);
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }

  Future deleteRecord(
      String token,
      String tableName,
      int id,
      ) async {
    try {
      String url = '$_baseUrl/$token/tables/$tableName/$id/delete';
      debugPrint('apiUrl ::: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map<String, dynamic> json = jsonDecode(response.body);
      if (_isRequestHaveMessage(json)) {
        _throwError(json);
      }

      if (response.statusCode == 200) {
        debugPrint('ApiClient deleteRecord SUCCESS response.body: ${response.body}');
      } else {
        debugPrint('ApiClient deleteRecord ERROR ::: ${response.body}');
        // throw Exception(response.body);
        throw ApiException();
      }
    } catch (e) {
      if (e is SocketException) throw ApiException();
      rethrow;
    }
  }*/

  bool _isRequestHaveMessage(Map json) {
    return json['message'] != null;
  }

  _throwError(Map json) {
    if (json['status'] == 'error' && json['message'] != null) {
      throw CustomException.fromApiMessage(json['message']);
    }

    // if (json['data']?['message'] == 'fail.token') {
    //   throw LoggedUserNotFoundException();
    // }
    // if (json['status'] == 'error' && json['data']?['message'] != null) {
    //   throw CustomException.fromApiMessage(json['data']['message'].toString());
    // }
    // if (json['data']?['errors'] != null) {
    //   Map<String, List<String>> errorMap =
    //       (json['data']['errors'] as Map).map((key, value) => MapEntry(key as String, value as List<String>));
    //   String message = '';
    //   for (int i = 0; i < errorMap.length; i++) {
    //     message += errorMap.values.toList()[i][0];
    //   }
    //   throw CustomException.fromApiMessage(message);
    // }
  }
}
