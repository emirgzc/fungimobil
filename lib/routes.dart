import 'package:flutter/material.dart';
import 'package:fungimobil/pages/about/misyon_page.dart';
import 'package:fungimobil/pages/about/team_page.dart';
import 'package:fungimobil/pages/about/vizyon_page.dart';
import 'package:fungimobil/pages/activity_detail/activity_detail_page.dart';
import 'package:fungimobil/pages/blog/blog.dart';
import 'package:fungimobil/pages/blog_detail/blog_detail_page.dart';
import 'package:fungimobil/pages/login_register/forget_password_page.dart';
import 'package:fungimobil/pages/login_register/login_page.dart';
import 'package:fungimobil/main.dart';
import 'package:fungimobil/pages/login_register/register_page.dart';

class Routes {
  static const String root = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String forgetPassPage = '/forgetPassPage';
  static const String activityDetailPage = '/activityDetailPage';
  static const String blogPage = '/blogPage';
  static const String blogDetailPage = '/blogDetailPage';
  static const String misyonPage = '/misyonPage';
  static const String vizyonPage = '/vizyonPage';
  static const String teamPage = '/teamPage';

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
      case activityDetailPage:
        page = const ActivityDetailPage();
        break;
      case blogPage:
        page = const BlogPage();
        break;
      case blogDetailPage:
        page = const BlogDetailPage();
        break;
      case misyonPage:
        page = const MisyonPage();
        break;
      case vizyonPage:
        page = const VizyonPage();
        break;
      case teamPage:
        page = const TeamPage();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      maintainState: false,
    );
  }
}
