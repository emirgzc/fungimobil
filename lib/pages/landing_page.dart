import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/widgets/loading_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (route) => false);
      // _checkUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingWidget();
  }

// _checkUser(BuildContext context) {
//   Provider.of<AuthViewModel>(context).isUserExists().then((value) {
//     if (value) {
//       Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (route) => false);
//     } else {
//       Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);
//     }
//   }).catchError((e) {
//     HandleExceptions.handle(exception: e, context: context, onDismiss: (context) {});
//     Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);
//   });
// }
}
