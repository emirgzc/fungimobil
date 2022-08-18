import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/login_text_fiedl.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sponsorlarımız"),
        centerTitle: true,
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(48.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigTitle(title: "İletişim Bilgileri", size: 72.sp),
              contactInfoTitle("İstanbul | Türkiye", Icons.home),
              contactInfoTitle("Telefon: 555 555 55 55", Icons.phone_android),
              contactInfoTitle(
                "Mail Adresi: info@fungiturkey.org",
                Icons.mail_outline_rounded,
              ),
              contactInfoTitle(
                "Yönetici: Ömer Üngör | Selçuk Ekşi",
                Icons.people_alt_outlined,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Row(
                  children: [
                    cardForSocialMedia(
                      "assets/icons/twitter.svg",
                    ),
                    cardForSocialMedia(
                      "assets/icons/instagram.svg",
                    ),
                    cardForSocialMedia(
                      "assets/icons/facebook.svg",
                    ),
                    cardForSocialMedia(
                      "assets/icons/whatsapp.svg",
                    ),
                  ],
                ),
              ),
              const LoginTextField(hintText: "İsim Soyisim"),
              const LoginTextField(hintText: "Mail Adresi"),
              const LoginTextField(hintText: "Telefon"),
              const LoginTextField(hintText: "Konu"),
              const LoginTextField(hintText: "Mesajınız"),
              const ButtonForLogin(title: "Gönder"),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardForSocialMedia(String iconSvg) {
    return Container(
      margin: EdgeInsets.only(right: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 36.h),
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
        height: 64.h,
      ),
    );
  }

  Padding contactInfoTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(icon, size: 20),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
