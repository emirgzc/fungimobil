import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/desc_title.dart';
import 'package:fungimobil/pages/login_register/components/login_text_fiedl.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      body: buildRegisterPage(),
    );
  }

  Widget buildRegisterPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 80.w,
          right: 80.w,
          top: 216.h,
        ),
        child: Center(
          child: Column(
            children: [
              BigTitle(title: "Kayıt Sayfası", size: 80.sp),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 48.h),
                child: DescTitle(
                  title:
                      "Fungi Turkey mobil uygulamasına kayıt olmak için aşağıdaki formu doldurunuz.",
                  size: 56.sp,
                ),
              ),
              const LoginTextField(hintText: "İsim Soyisim"),
              const LoginTextField(hintText: "Mail Adresi"),
              const LoginTextField(hintText: "Telefon Numarası"),
              const LoginTextField(hintText: "Şehir"),
              const LoginTextField(hintText: "Meslek"),
              const LoginTextField(hintText: "Şifre"),
              const LoginTextField(hintText: "Şifre Tekrar"),
              const ButtonForLogin(title: "Kayıt Ol"),
            ],
          ),
        ),
      ),
    );
  }
}
