import 'package:flutter/material.dart';
import 'package:fungimobil/pages/login_register/forget_password_page.dart';
import 'package:fungimobil/pages/login_register/login_page.dart';
import 'package:fungimobil/main.dart';
import 'package:fungimobil/pages/login_register/register_page.dart';

class Routes {
  static const String root = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String forgetPassPage = '/forgetPassPage';

  static Route? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const DemoPage();
        break;
      case loginPage:
        page = const LoginPage();
        break;
      case registerPage:
        page = const RegisterPage();
        break;
      case forgetPassPage:
        page = const ForgetPasswordPage();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      maintainState: false,
    );
  }
}
