import 'package:flutter/material.dart';
import 'package:fungimobil/login_page.dart';
import 'package:fungimobil/main.dart';

class Routes {
  static const String root = '/';
  static const String loginPage = '/loginPage';

  static Route? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const DemoPage();
        break;
      case loginPage:
        page = const LoginPage();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      maintainState: false,
    );
  }
}
