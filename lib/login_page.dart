import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
      ),
      body: buildLoginPageBody(),
    );
  }

  Widget buildLoginPageBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              bigTitle(),
              Padding(
                padding: EdgeInsets.only(
                  left: 60.w,
                  right: 60.w,
                  top: 48.h,
                  bottom: 120.h,
                ),
                child: descTitle(),
              ),
              buildTextField("Mail Adresi"),
              buildTextField("Şifre"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: forgetPassTitle(),
              ),
              buttonSignIn(),
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
    return Row(
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
    );
  }

  Widget cardForSocialMedia(String iconSvg) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 72.w, vertical: 40.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: const Color(0xffF4A261).withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: SvgPicture.asset(
        iconSvg,
        color: Colors.black.withOpacity(0.8),
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
            color: Colors.black.withOpacity(0.15),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
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
            color: Colors.black.withOpacity(0.15),
          ),
        ),
      ],
    );
  }

  Widget buttonSignIn() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 64.h),
        padding: EdgeInsets.symmetric(vertical: 36.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffF4A261),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Center(
          child: Text(
            "Giriş Yap",
            style: TextStyle(
              fontSize: 64.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget forgetPassTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Şifremi Unuttum?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget descTitle() {
    return Text(
      "Fungi Turkey Mobil Uygulamasına Hoşgeldiniz.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 72.sp,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget bigTitle() {
    return Text(
      "Fungi Turkey",
      style: TextStyle(
        fontSize: 98.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xffF4A261),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 160.h,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
          contentPadding: EdgeInsets.symmetric(horizontal: 48.w),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
      ),
    );
  }
}
