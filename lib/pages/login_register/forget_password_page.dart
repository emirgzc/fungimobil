import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/desc_title.dart';
import 'package:fungimobil/pages/login_register/components/login_text_fiedl.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: forgetPassBody(),
    );
  }

  Widget forgetPassBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: Image.asset("assets/images/black.png", height: 260.h),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: BigTitle(title: "Şifremi Unuttum?", size: 72.sp),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 48.h),
              child: DescTitle(
                title:
                    "Aşağıdaki alana mail adresinizi girerek şifrenizi yenileyebilirsiniz.",
                size: 56.sp,
              ),
            ),
            const LoginTextField(hintText: "Mail Adresi"),
            const ButtonForLogin(title: "Gönder"),
          ],
        ),
      ),
    );
  }
}
