import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/desc_title.dart';
import 'package:fungimobil/pages/login_register/forgot_password.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';
import 'package:fungimobil/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '';

  AuthViewModel? _authProvider;

  // @override
  // void dispose() {
  //   _authProvider?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    _authProvider = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: getAppBar("Giriş Yap"),
      body: Stack(
        children: [
          buildLoginPageBody(),
          if (_authProvider!.status == AuthVMStatus.busy) const LoadingWidget(),
        ],
      ),
    );
  }

  Widget buildLoginPageBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigTitle(title: "Fungi Turkey", size: 98.sp),
              Padding(
                padding: EdgeInsets.only(
                  left: 60.w,
                  right: 60.w,
                  top: 48.h,
                  bottom: 120.h,
                ),
                child: DescTitle(
                  title: "Fungi Turkey Mobil Uygulamasına Hoşgeldiniz.",
                  size: 72.sp,
                ),
              ),
              CustomTextField(
                hintText: "Mail Adresi",
                onChanged: (value) {
                  if (value != null) email = value;
                },
              ),
              CustomTextField(
                hintText: "Şifre",
                onChanged: (value) {
                  if (value != null) password = value;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: forgetPassTitle(),
              ),
              ButtonForLogin(
                title: "Giriş Yap",
                onTap: _login,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 64.h),
                child: orContinue(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 48.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    cardForSocialMedia("assets/icons/google.svg"),
                    cardForSocialMedia("assets/icons/apple.svg"),
                    cardForSocialMedia("assets/icons/facebook.svg"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.h),
                child: registerTitle(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerTitle() {
    return GestureDetector(
      onTap: _navigateToRegister,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Text(
              "Üye değil misiniz?",
              style: TextStyle(
                fontSize: 40.sp,
              ),
            ),
          ),
          Text(
            "Şimdi Üye Olun",
            style: TextStyle(
              fontSize: 40.sp,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardForSocialMedia(String iconSvg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 72.w, vertical: 40.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Style.secondaryColor.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
      ),
      child: SvgPicture.asset(
        iconSvg,
        color: Style.textColor.withOpacity(0.8),
      ),
    );
  }

  Widget orContinue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 6.h,
            color: Style.textColor.withOpacity(0.15),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Style.defautlHorizontalPadding),
          child: Text(
            "ya da devam et",
            style: TextStyle(
              fontSize: 40.sp,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 6.h,
            color: Style.textColor.withOpacity(0.15),
          ),
        ),
      ],
    );
  }

  Widget forgetPassTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            ForgotPassword.forgotPassword(context);
          },
          child: Text(
            "Şifremi Unuttum?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  _login() {
    try {
      _authProvider!.login(email, password).then((value) => _navigateHome());
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context, onDismiss: (context) {});
    }
  }

  _navigateHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.homePage,
      (route) => false,
    );
  }

  _navigateToRegister() {
    Navigator.pushNamed(context, Routes.registerPage);
  }
}
