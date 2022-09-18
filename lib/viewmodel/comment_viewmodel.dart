import 'package:flutter/material.dart';
import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/model/user_model.dart';
import 'package:fungimobil/repository/auth_repository.dart';
import 'package:fungimobil/repository/table_repository.dart';

class CommentViewModel extends ChangeNotifier {
  final TableRepository _tableRepository = locator<TableRepository>();
  final AuthRepository _authRepository = locator<AuthRepository>();

  Future storeComment(
      {required String comment, required String tableName, required Map<String, dynamic> filter}) async {
    UserModel userInfo = await _authRepository.getUserInfoFromLocale();

    Map<String, dynamic> data = {
      'name': userInfo.name,
      'surname': userInfo.surname,
      'member_id': userInfo.id,
      'comment': comment,
    };
    data.addAll(filter);

    return await _tableRepository.tableStore(tableName: tableName, data: data);
  }
}
