import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/widgets/card_for_social_media.dart';
import 'package:fungimobil/widgets/text_field.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key}) : super(key: key);

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage>
    with TickerProviderStateMixin {
  AnimationController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: activityDetailBody(context),
    );
  }

  Widget activityDetailBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            height: 900.h,
            width: double.infinity,
            child: Image.asset(
              'assets/images/abc.jpg',
              fit: BoxFit.cover,
            ),
          ),
          arrowBack(),

          buttonForRecord(),
          // buttonForRecord(),
          Container(
            padding: Style.defaultPagePadding,
            margin: EdgeInsets.only(top: 900.h),
            color: Style.primaryColor,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleAndDate(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Style.defaultPadding * (3 / 2),
                  ),
                  child: socialCardandPrice(),
                ),
                bigTitle(),
                Padding(
                  padding: EdgeInsets.only(top: Style.defautlVerticalPadding),
                  child: desc(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding),
                  child: titleForActivity("Etkinlik Bilgisi"),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: Style.defautlVerticalPadding),
                  child: infoActivity(),
                ),
                titleForActivity("Konum Bilgisi"),
                Padding(
                  padding: EdgeInsets.only(
                      top: Style.defautlVerticalPadding,
                      bottom: Style.defautlVerticalPadding / 2),
                  child: map(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding),
                  child: commentTitle(context),
                ),
                commentForActivity(),
                SizedBox(
                  height: 300.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget commentTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        titleForActivity("Yorumlar :"),
        Padding(
          padding: EdgeInsets.only(left: Style.defautlHorizontalPadding / 2),
          child: Text(
            "Toplam 12 Yorum",
            style: TextStyle(
              fontSize: 56.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            menuPop(context);
          },
          child: Text(
            "Tüm Yorumlar",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: Style.defaultTextSize * (3 / 4),
            ),
          ),
        ),
      ],
    );
  }

  Widget map() {
    return Image.asset("assets/images/osmanli.jpg");
  }

  Widget infoActivity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 136.h,
          margin: EdgeInsets.only(right: Style.defautlHorizontalPadding / 2),
          padding: EdgeInsets.symmetric(
            horizontal: Style.defautlHorizontalPadding / 2,
            vertical: Style.defautlVerticalPadding / 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Style.secondaryColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Column(
            children: [
              Text(
                "Bitiş Tarihi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Style.defaultTextSize,
                ),
              ),
              const Expanded(
                child: Text("17 Ağustos 2022 - 16:50"),
              ),
            ],
          ),
        ),
        Container(
          height: 136.h,
          padding: EdgeInsets.symmetric(
            horizontal: Style.defautlHorizontalPadding / 2,
            vertical: Style.defautlVerticalPadding / 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Style.secondaryColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Column(
            children: [
              Text(
                "Yapımcı",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Style.defaultTextSize,
                ),
              ),
              const Expanded(
                child: Text("Ömer Üngör, Selçuk Ekşi"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget titleForActivity(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget desc() {
    return Text(
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
          20,
      style: TextStyle(
        fontSize: Style.defaultTextSize,
        color: Style.textColor.withOpacity(0.6),
      ),
    );
  }

  Widget bigTitle() {
    return Text(
      "One of best destinations in Turkey",
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget socialCardandPrice() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Style.secondaryColor,
                  size: 60.r,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: Style.defautlHorizontalPadding / 4),
                  child: Text(
                    "Bolu, Türkiye",
                    style: TextStyle(
                      fontSize: Style.defaultTextSize,
                      color: Style.textColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Style.defautlVerticalPadding),
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
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "750",
                  style: TextStyle(
                    fontSize: 96.sp,
                    fontWeight: FontWeight.w500,
                    color: Style.secondaryColor,
                  ),
                ),
                Text(
                  ",00 ₺",
                  style: TextStyle(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w500,
                    color: Style.secondaryColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                "/1 Kişi için",
                style: TextStyle(
                  fontSize: Style.defaultTextSize,
                  color: Style.textColor.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                "Kontenjan : 30",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Style.textColor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget titleAndDate() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Mykonos",
          style: TextStyle(
            fontSize: 100.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Style.defautlHorizontalPadding / 2,
            vertical: Style.defautlVerticalPadding / 4,
          ),
          decoration: BoxDecoration(
            color: Style.secondaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Style.secondaryColor,
                size: 60.r,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: Style.defautlHorizontalPadding / 4),
                child: Text(
                  "15 Ağustos 2022",
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: Style.textColor.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget commentForActivity() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.symmetric(
              vertical: Style.defautlVerticalPadding / 2,
            ),
            width: 800.w,
            child: const CustomTextField(hintText: "Yorum Yap")),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24.r),
            decoration: const BoxDecoration(
              color: Style.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ],
    );
  }

  Widget buttonForRecord() {
    return Positioned(
      top: 130.h,
      right: 48.w,
      child: GestureDetector(
        onTap: () => recordPop(context),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Style.defautlVerticalPadding / 4,
              horizontal: Style.defautlHorizontalPadding / 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "Son Tarih : 15 Ağustos 2022",
                style: TextStyle(
                  color: Style.dangerColor,
                  fontSize: 13,
                ),
              ),
              Text("Kayıt için tıkla"),
            ],
          ),
        ),
      ),
    );
  }

  Widget arrowBack() {
    return Positioned(
      top: 130.h,
      left: 48.w,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.all(30.r),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  Future menuPop(BuildContext context) {
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
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Style.defautlVerticalPadding / 2,
                  horizontal: Style.defautlHorizontalPadding / 2,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 8.h,
                          width: 300.w,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Style.defautlHorizontalPadding,
                          top: Style.defautlVerticalPadding * 2),
                      child: Row(
                        children: [
                          Text(
                            "12 Yorum",
                            style: TextStyle(
                              fontSize: Style.bigTitleTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: 12,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minLeadingWidth: 0,
                          dense: true,
                          leading:
                              const Icon(Icons.supervised_user_circle_outlined),
                          title: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Style.defautlHorizontalPadding / 2),
                                child: Text(
                                  "Emir Gözcü",
                                  style: TextStyle(
                                    fontSize: Style.bigTitleTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "2 saat önce",
                                style: TextStyle(
                                  fontSize: 40.sp,
                                ),
                              ),
                            ],
                          ),
                          subtitle: const Text(
                            "Lorem Ipsum has been the industry's stand",
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64.r,
                              ),
                              const Text("15"),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future recordPop(BuildContext context) {
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
              horizontal: Style.defautlHorizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 8.h,
                    width: 300.w,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Style.defautlVerticalPadding),
                child: Text(
                  "Etkinlik Kayıt",
                  style:
                      TextStyle(fontSize: 62.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const CustomTextField(hintText: "İsim Soyisim"),
              const CustomTextField(hintText: "Mail Adresi"),
              const CustomTextField(hintText: "Telefon Numarası"),
              const CustomTextField(hintText: "Kişi Sayısı"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 0,
                    groupValue: 1,
                    onChanged: (value) {},
                  ),
                  const Text(
                    "Açık Rıza Metnini ",
                    style: TextStyle(color: Colors.blue),
                  ),
                  const Text("Okudum ve Kabul Ediyorum."),
                ],
              ),
              const ButtonForLogin(title: "Kayıt Ol"),
            ],
          ),
        );
      },
    );
  }
}
