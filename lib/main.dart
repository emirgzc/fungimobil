import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2280),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Style.primaryColor,
              elevation: 0,
              foregroundColor: Style.textColor,
            ),
            scaffoldBackgroundColor: Style.primaryColor,
          ),
          debugShowCheckedModeBanner: false,
          home: const DemoPage(),
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildButton(
                'Login Page',
                () {
                  Navigator.pushNamed(context, Routes.loginPage);
                },
              ),
              buildButton(
                'Register Page',
                () {
                  Navigator.pushNamed(context, Routes.registerPage);
                },
              ),
              buildButton(
                'Forget Password Page',
                () {
                  Navigator.pushNamed(context, Routes.forgetPassPage);
                },
              ),
              buildButton(
                'Activity Detail Page',
                () {
                  Navigator.pushNamed(context, Routes.activityDetailPage);
                },
              ),
              buildButton(
                'Blog Page',
                () {
                  Navigator.pushNamed(context, Routes.blogPage);
                },
              ),
              buildButton(
                'Blog Detail Page',
                () {
                  Navigator.pushNamed(context, Routes.blogDetailPage);
                },
              ),
              buildButton(
                'About Page',
                () {
                  Navigator.pushNamed(context, Routes.aboutPage);
                },
              ),
              buildButton(
                'Team Page',
                () {
                  Navigator.pushNamed(context, Routes.teamPage);
                },
              ),
              buildButton(
                'Service Page',
                () {
                  Navigator.pushNamed(context, Routes.servicePage);
                },
              ),
              buildButton(
                'Activity Page',
                () {
                  Navigator.pushNamed(context, Routes.activityPage);
                },
              ),
              buildButton(
                'Galery Page',
                () {
                  Navigator.pushNamed(context, Routes.galeryPage);
                },
              ),
              buildButton(
                'Sponsor Page',
                () {
                  Navigator.pushNamed(context, Routes.sponsorPage);
                },
              ),
              buildButton(
                'Contact Page',
                () {
                  Navigator.pushNamed(context, Routes.contactPage);
                },
              ),
              buildButton(
                'Home Page',
                () {
                  Navigator.pushNamed(context, Routes.homePage);
                },
              ),
              buildButton(
                'Profile Page',
                () {
                  Navigator.pushNamed(context, Routes.profilePage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(
    String title,
    Function() onPressed,
  ) {
    return Container(
      margin: EdgeInsets.only(
          bottom: Style.defautlVerticalPadding / 2,
          top: Style.defautlVerticalPadding / 4),
      height: Style.defautlVerticalPadding * 2,
      child: ElevatedButton(
        child: Text(title),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
