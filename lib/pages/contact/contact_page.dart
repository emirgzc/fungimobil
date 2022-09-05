import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/card_for_social_media.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("İletişim"),
      body: contactBody(),
    );
  }

  Widget contactBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
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
              padding:
                  EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
              child: Row(
                children: const [
                  CardForSocialMedia(
                    iconSvg: "assets/icons/twitter.svg",
                  ),
                  CardForSocialMedia(
                    iconSvg: "assets/icons/instagram.svg",
                  ),
                  CardForSocialMedia(
                    iconSvg: "assets/icons/facebook.svg",
                  ),
                  CardForSocialMedia(
                    iconSvg: "assets/icons/whatsapp.svg",
                  ),
                ],
              ),
            ),
            CustomTextField(hintText: "İsim Soyisim"),
            CustomTextField(hintText: "Mail Adresi"),
            CustomTextField(hintText: "Telefon"),
            CustomTextField(hintText: "Konu"),
            CustomTextField(hintText: "Mesajınız"),
            const ButtonForLogin(title: "Gönder"),
          ],
        ),
      ),
    );
  }

  Widget contactInfoTitle(String title, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: Style.defautlHorizontalPadding / 4),
            child: Icon(icon, size: 60.r),
          ),
          Text(
            title,
            style: TextStyle(fontSize: Style.defaultTextSize),
          ),
        ],
      ),
    );
  }
}
