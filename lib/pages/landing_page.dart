import 'package:flutter/material.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _checkUser(context);
    return const LoadingWidget();
  }

  _checkUser(BuildContext context) {
    Provider.of<AuthViewModel>(context).isUserExists().then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);
      }
    }).catchError((e) {
      HandleExceptions.handle(exception: e, context: context, onDismiss: (context) {});
      Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);
    });
  }
}
