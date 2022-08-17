import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/routes.dart';

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
        return const MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: DemoPage(),
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
      body: Center(
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
              'Misyon Page',
              () {
                Navigator.pushNamed(context, Routes.misyonPage);
              },
            ),
            buildButton(
              'Vizyon Page',
              () {
                Navigator.pushNamed(context, Routes.vizyonPage);
              },
            ),
            buildButton(
              'Team Page',
              () {
                Navigator.pushNamed(context, Routes.teamPage);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container buildButton(
    String title,
    Function() onPressed,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, top: 4),
      height: 36,
      child: ElevatedButton(
        child: Text(title),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
