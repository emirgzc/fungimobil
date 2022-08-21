import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/text_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Profil Sayfası"),
      body: profileBody(context),
    );
  }

  Widget profileBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          children: [
            editIcon(context),
            Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(bottom: Style.defautlVerticalPadding / 2),
                  padding: EdgeInsets.all(100.r),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Style.secondaryColor.withOpacity(0.4),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "E G",
                    style: TextStyle(
                      fontSize: Style.bigTitleTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding / 4),
                  child: Text(
                    "Muhammed Emir Gözcü",
                    style: TextStyle(
                      fontSize: 56.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mail_outline_rounded,
                      size: 40.r,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: Style.defautlHorizontalPadding,
                          left: Style.defautlHorizontalPadding / 4),
                      child: const Text("emirgzc4@gmail.com"),
                    ),
                    Icon(
                      Icons.phone_android_outlined,
                      size: 40.r,
                    ),
                    const Text("0 555 555 55 55"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding),
                  child: Text(
                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
                        4,
                    style: TextStyle(
                      fontSize: 44.sp,
                      color: Style.textColor.withOpacity(0.6),
                    ),
                  ),
                ),
                profileMenuItem(
                  () {
                    Navigator.pushNamed(context, Routes.blogCommentPage);
                  },
                  "Blog Yorumlarım",
                  12,
                ),
                profileMenuItem(
                  () {
                    Navigator.pushNamed(context, Routes.activityCommentPage);
                  },
                  "Etkinlik Yorumlarım",
                  6,
                ),
                profileMenuItem(
                  () {
                    Navigator.pushNamed(context, Routes.recordListPage);
                  },
                  "Kayıtlarım",
                  8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget profileMenuItem(void Function()? onTap, String title, int count) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200.h,
        margin: EdgeInsets.only(
          bottom: Style.defautlVerticalPadding / 4,
          top: Style.defautlVerticalPadding / 2,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 2,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Style.defaultTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$count Yorum"),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Style.textColor.withOpacity(0.6),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget editIcon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => editPop(context),
          child: Container(
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Style.secondaryColor.withOpacity(0.4),
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }

  Future editPop(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Style.defaultRadiusSize),
          topRight: Radius.circular(Style.defaultRadiusSize),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Style.defautlVerticalPadding,
              horizontal: Style.defautlHorizontalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profil Güncelleme",
                        style: TextStyle(
                          fontSize: Style.bigTitleTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const CustomTextField(hintText: "İsim Soyisim"),
                const CustomTextField(hintText: "Mail Adresi"),
                const CustomTextField(hintText: "Telefon Numarası"),
                const CustomTextField(hintText: "Şehir"),
                const CustomTextField(hintText: "Meslek"),
                const CustomTextField(hintText: "Hakkımda"),
                const CustomTextField(hintText: "Şifre"),
                const CustomTextField(hintText: "Şifre Tekrar"),
                const ButtonForLogin(title: "Güncelle"),
              ],
            ),
          ),
        );
      },
    );
  }
}
