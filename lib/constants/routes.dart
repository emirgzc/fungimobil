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
import 'package:fungimobil/viewmodel/config_viewmodel.dart';
import 'package:provider/provider.dart';

import '../viewmodel/table_view_model.dart';

class Routes {
  static const String root = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = '/registerPage';
  static const String forgetPassPage = '/forgetPassPage';
  static const String activityDetailPage = '/activityDetailPage';
  static const String blogPage = '/blog';
  static const String blogDetailPage = '/blogDetailPage';
  static const String aboutPage = '/hakkimizda';
  static const String teamPage = '/takim';
  static const String servicePage = '/organizasyon';
  static const String activityPage = '/etkinlik';
  static const String galeryPage = '/galeri';
  static const String sponsorPage = '/sponsor';
  static const String contactPage = '/iletisim';
  static const String homePage = '/homePage';
  static const String profilePage = '/profilePage';
  static const String blogCommentPage = '/blogCommentPage';
  static const String activityCommentPage = '/activityCommentPage';
  static const String recordListPage = '/recordListPage';

  static Route? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = ChangeNotifierProvider(
            create: (_) => ConfigViewModel(), child: const LandingPage());
        break;
      case loginPage:
        page = LoginPage();
        break;
      case registerPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: RegisterPage(),
        );
        break;
      case forgetPassPage:
        page = const ForgetPasswordPage();
        break;
      case activityDetailPage:
        page = ChangeNotifierProvider(
            create: (_) => TableViewModel(),
            child: ActivityDetailPage(
              data: settings.arguments as Map<String, dynamic>,
            ));
        break;
      case blogPage:
        page = ChangeNotifierProvider(
            create: (_) => TableViewModel(), child: const BlogPage());
        break;
      case blogDetailPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: BlogDetailPage(
            id: settings.arguments.toString(),
          ),
        );
        break;
      case aboutPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const AboutPage(),
        );
        break;
      case teamPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const TeamPage(),
        );
        break;
      case servicePage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const ServicePage(),
        );
        break;
      case activityPage:
        page = ChangeNotifierProvider(
          create: (context) => TableViewModel(),
          child: const ActivityPage(),
        );
        break;
      case galeryPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const GaleryPage(),
        );
        break;
      case sponsorPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const SponsorPage(),
        );
        break;
      case contactPage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const ContactPage(),
        );
        break;
      case homePage:
        page = MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TableViewModel()),
            ChangeNotifierProvider(create: (_) => ConfigViewModel()),
          ],
          child: const HomePage(),
        );
        break;
      case profilePage:
        page = ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: const ProfilePage(),
        );
        break;
      case blogCommentPage:
        page = ChangeNotifierProvider(
            create: (context) => TableViewModel(),
            child: const BlogCommentList());
        break;
      case activityCommentPage:
        page = const ActivityCommentList();
        break;
      case recordListPage:
        page = const RecordList();
        break;
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      maintainState: false,
    );
  }
}
