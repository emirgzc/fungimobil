import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';

AppBar getAppBar(String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    backgroundColor: Style.primaryColor,
    elevation: 0,
    foregroundColor: Style.textColor,
  );
}
