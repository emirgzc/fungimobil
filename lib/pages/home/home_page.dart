import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/home/components/home_drawer.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomePage(context),
      drawer: const HomeDrawer(),
      body: homePageBody(context),
    );
  }

  Widget homePageBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
              child: Text(
                "Hoşgeldin Ömer Üngör,",
                style: TextStyle(
                  fontSize: Style.bigTitleTextSize,
                  color: Style.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Fungi Turkey ©",
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                color: Style.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: CustomTextField(
                hintText: "Aramak istediğiniz kelime",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: const Icon(Icons.sort),
              ),
            ),
            titleForRow(
              "Etkinlikler",
              "Tümünü Göster",
              () => Navigator.pushNamed(context, Routes.activityPage),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 5; i++) actHomeCard(context),
                ],
              ),
            ),
            titleForRow(
              "Bloglar",
              "Tümünü Göster",
              () => Navigator.pushNamed(context, Routes.blogPage),
            ),
            Padding(
              padding: EdgeInsets.only(top: 48.h),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return blogCard(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget blogCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.blogDetailPage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 20.h),
        height: 330.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          boxShadow: [Style.defaultShadow],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: SizedBox(
                width: 420.w,
                height: 300.h,
                child: Image.asset(
                  "assets/images/fungi2.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mantar Toplanması İçin Gereken Eşyalar",
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
                        2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: Style.defaultTextSize / (4 / 3),
                    ),
                  ),
                  const Text(
                    "12 Ağustos 2022",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actHomeCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.activityDetailPage);
      },
      child: Container(
        margin: EdgeInsets.only(top: 48.h, bottom: 48.h, right: 24.w),
        width: 660.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          boxShadow: [Style.defaultShadow],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 18.h,
            bottom: 40.h,
            right: 18.w,
            left: 18.w,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/fungi1.jpeg"),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 12.w,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(
                          Style.defaultRadiusSize / 2,
                        ),
                      ),
                      child: Text(
                        "Son Kayıt : 12 Haziran 2022",
                        style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w500,
                          color: Style.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Text(
                  "Fungi Turkey Mantar Etkinliği",
                  style: TextStyle(
                    fontSize: 56.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: SvgPicture.asset(
                      "assets/icons/locations.svg",
                      height: 36.r,
                    ),
                  ),
                  Text(
                    "Bolu/Türkiye",
                    style: TextStyle(
                      fontSize: 44.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleForRow(String titleOne, String titleTwo, void Function()? onTap) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleOne,
          style: TextStyle(
            fontSize: Style.bigTitleTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            titleTwo,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: Style.bigTitleTextSize * (2 / 3),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  AppBar appBarHomePage(BuildContext context) {
    return AppBar(
      toolbarHeight: 220.h,
      foregroundColor: Style.textColor,
      title: Image.asset(
        "assets/images/black.png",
        fit: BoxFit.cover,
        height: 120.h,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            editPop(context);
          },
          child: Container(
            margin: EdgeInsets.only(right: 36.w),
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Style.textColor.withOpacity(0.15),
              ),
            ),
            child: const Icon(Icons.people_alt_outlined),
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
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: Style.defautlVerticalPadding,
            horizontal: Style.defautlHorizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              profileMenuCard(
                context,
                "Profil",
                "assets/icons/users.svg",
                () => Navigator.pushNamed(context, Routes.profilePage),
              ),
              profileMenuCard(
                context,
                "Çıkış Yap",
                "assets/icons/exit.svg",
                () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileMenuCard(
      BuildContext context, String title, String icon, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 12.h),
        margin: EdgeInsets.only(bottom: 28.h),
        decoration: BoxDecoration(
          color: Style.primaryColor,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          // color: Colors.red,
        ),
        child: ListTile(
          dense: true,
          leading: SvgPicture.asset(
            icon,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          title: Text(title),
        ),
      ),
    );
  }
}
