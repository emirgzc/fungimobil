import 'package:flutter/material.dart';
import 'package:fungimobil/constants/locator.dart';
import 'package:fungimobil/repository/config_repository.dart';

import '../model/menu_model.dart';

class ConfigViewModel extends ChangeNotifier {
  final ConfigRepository _repository = locator<ConfigRepository>();

  List<MenuModel>? menuList;

  Future<bool> saveMenu() {
    return _repository.saveMenu();
  }

  Future<List<MenuModel>> getMenu() async {
    menuList = await _repository.getMenu();
    notifyListeners();
    return menuList!;
  }
}