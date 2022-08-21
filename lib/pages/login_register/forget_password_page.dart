import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/desc_title.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/text_field.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Şifremi Unuttum"),
      body: forgetPassBody(),
    );
  }

  Widget forgetPassBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: Image.asset(
                "assets/images/black.png",
                height: 260.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: BigTitle(title: "Şifremi Unuttum?", size: 72.sp),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
              child: DescTitle(
                title:
                    "Aşağıdaki alana mail adresinizi girerek şifrenizi yenileyebilirsiniz.",
                size: 56.sp,
              ),
            ),
            const CustomTextField(hintText: "Mail Adresi"),
            const ButtonForLogin(title: "Gönder"),
          ],
        ),
      ),
    );
  }
}
