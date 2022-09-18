import 'package:flutter/material.dart';
import 'package:fungimobil/pages/about/about_page.dart';
import 'package:fungimobil/pages/about/team_page.dart';
import 'package:fungimobil/pages/activity/activity_page.dart';
import 'package:fungimobil/pages/activity_detail/activity_detail_page.dart';
import 'package:fungimobil/pages/blog/blog_page.dart';
import 'package:fungimobil/pages/blog_detail/blog_detail_page.dart';
import 'package:fungimobil/pages/contact/contact_page.dart';
import 'package:fungimobil/pages/galery/galery_page.dart';
import 'package:fungimobil/pages/home/home_page.dart';
import 'package:fungimobil/pages/landing_page.dart';
import 'package:fungimobil/pages/login_register/forget_password_page.dart';
import 'package:fungimobil/pages/login_register/login_page.dart';
import 'package:fungimobil/pages/login_register/register_page.dart';
import 'package:fungimobil/pages/organizasyon/service_page.dart';
import 'package:fungimobil/pages/profile/activity_comment_list.dart';
import 'package:fungimobil/pages/profile/blog_comment_list.dart';
import 'package:fungimobil/pages/profile/profile_page.dart';
import 'package:fungimobil/pages/profile/record_list.dart';
import 'package:fungimobil/pages/sponsor/sponsor_page.dart';
import 'package:provider/provider.dart';

import '../viewmodel/table_view_model.dart';

class Routes {
  static const String root = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String forgetPassPage = '/forgetPassPage';
  static const String activityDetailPage = '/activityDetailPage';
  static const String blogPage = '/blogPage';
  static const String blogDetailPage = '/blogDetailPage';
  static const String aboutPage = '/aboutPage';
  static const String teamPage = '/teamPage';
  static const String servicePage = '/servicePage';
  static const String activityPage = '/activityPage';
  static const String galeryPage = '/galeryPage';
  static const String sponsorPage = '/sponsorPage';
  static const String contactPage = '/contactPage';
  static const String homePage = '/homePage';
  static const String profilePage = '/profilePage';
  static const String blogCommentPage = '/blogCommentPage';
  static const String activityCommentPage = '/activityCommentPage';
  static const String recordListPage = '/recordListPage';

  static Route? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const LandingPage();
        break;
      case loginPage:
        page = SafeArea(child: LoginPage());
        break;
      case registerPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: SafeArea(child: RegisterPage()),
        );
        break;
      case forgetPassPage:
        page = const SafeArea(child: ForgetPasswordPage());
        break;
      case activityDetailPage:
        page = ChangeNotifierProvider(
            create: (_) => TableViewModel(),
            child: SafeArea(
                child: ActivityDetailPage(
              data: settings.arguments as Map<String, dynamic>,
            )));
        break;
      case blogPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const SafeArea(child: BlogPage()),
        );
        break;
      case blogDetailPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: SafeArea(
              child: BlogDetailPage(
            id: settings.arguments as String,
          )),
        );
        break;
      case aboutPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const SafeArea(child: AboutPage()),
        );
        break;
      case teamPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const SafeArea(child: TeamPage()),
        );
        break;
      case servicePage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const SafeArea(child: ServicePage()),
        );
        break;
      case activityPage:
        page = ChangeNotifierProvider(
            create: (context) => TableViewModel(),
            child: const SafeArea(child: ActivityPage()));
        break;
      case galeryPage:
        page = ChangeNotifierProvider(
            create: (context) => TableViewModel(),
            child: const SafeArea(child: GaleryPage()));
        break;
      case sponsorPage:
        page = const SafeArea(child: SponsorPage());
        break;
      case contactPage:
        page = const SafeArea(child: ContactPage());
        break;
      case homePage:
        page = ChangeNotifierProvider(
            create: (_) => TableViewModel(),
            child: SafeArea(child: HomePage()));
        break;
      case profilePage:
        page = ChangeNotifierProvider(
            create: (_) => TableViewModel(),
            child: const SafeArea(child: ProfilePage()));
        break;
      case blogCommentPage:
        page = const SafeArea(child: BlogCommentList());
        break;
      case activityCommentPage:
        page = const SafeArea(child: ActivityCommentList());
        break;
      case recordListPage:
        page = const SafeArea(child: RecordList());
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      maintainState: false,
    );
  }
}
