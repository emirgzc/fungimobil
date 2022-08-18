import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/login_text_fiedl.dart';

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
      body: SingleChildScrollView(
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
              padding: EdgeInsets.all(48.r),
              margin: EdgeInsets.only(top: 900.h),
              color: const Color(0xffF9F9F9),
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleAndDate(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 72.h),
                    child: socialCardandPrice(),
                  ),
                  bigTitle(),
                  Padding(
                    padding: EdgeInsets.only(top: 48.h),
                    child: desc(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    child: titleForActivity("Etkinlik Bilgisi"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 48.h),
                    child: infoActivity(),
                  ),
                  titleForActivity("Konum Bilgisi"),
                  Padding(
                    padding: EdgeInsets.only(top: 48.h, bottom: 24.h),
                    child: map(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
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
      ),
    );
  }

  Widget commentTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        titleForActivity("Yorumlar :"),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
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
          child: const Text(
            "Tüm Yorumlar",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12,
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
          margin: EdgeInsets.only(right: 24.w),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xffF4A261).withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            children: [
              Text(
                "Bitiş Tarihi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.sp,
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
            horizontal: 24.w,
            vertical: 12.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xffF4A261).withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            children: [
              Text(
                "Yapımcı",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.sp,
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
        fontSize: 64.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget desc() {
    return Text(
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
          20,
      style: TextStyle(
        fontSize: 48.sp,
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  Text bigTitle() {
    return Text(
      "One of best destinations in Turkey",
      style: TextStyle(
        fontSize: 64.sp,
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
                  color: Color(0xffF4A261),
                  size: 60.r,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                    "Bolu, Türkiye",
                    style: TextStyle(
                      fontSize: 48.sp,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
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
                    color: Color(0xffF4A261),
                  ),
                ),
                Text(
                  ",00 ₺",
                  style: TextStyle(
                    fontSize: 60.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffF4A261),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                "/1 Kişi için",
                style: TextStyle(
                  fontSize: 48.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                "Kontenjan : 30",
                style: TextStyle(
                  fontSize: 40.sp,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row titleAndDate() {
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
            horizontal: 24.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: Color(0xffF4A261).withOpacity(0.3),
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Color(0xffF4A261),
                size: 60.r,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  "15 Ağustos 2022",
                  style: TextStyle(
                    fontSize: 40.sp,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row commentForActivity() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 24.h),
          width: 800.w,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Yorum Yap",
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.3),
              ),
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
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24.r),
            decoration: const BoxDecoration(
              color: Color(0xffF4A261),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ],
    );
  }

  Positioned buttonForRecord() {
    return Positioned(
      top: 130.h,
      right: 48.w,
      child: GestureDetector(
        onTap: () => recordPop(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "Son Tarih : 15 Ağustos 2022",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),
              Text("Kayıt Ol"),
            ],
          ),
        ),
      ),
    );
  }

  Positioned arrowBack() {
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
          topLeft: Radius.circular(48.r),
          topRight: Radius.circular(48.r),
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
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
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
                      padding: EdgeInsets.only(left: 48.w, top: 72.h),
                      child: Row(
                        children: [
                          Text(
                            "12 Yorum",
                            style: TextStyle(
                              fontSize: 64.sp,
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
                                padding: EdgeInsets.only(right: 24.w),
                                child: Text(
                                  "Emir Gözcü",
                                  style: TextStyle(
                                    fontSize: 48.sp,
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
          topLeft: Radius.circular(48.r),
          topRight: Radius.circular(48.r),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 48.w),
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
                padding: EdgeInsets.symmetric(vertical: 48.h),
                child: Text(
                  "Etkinlik Kayıt",
                  style:
                      TextStyle(fontSize: 62.sp, fontWeight: FontWeight.bold),
                ),
              ),
              const LoginTextField(hintText: "İsim Soyisim"),
              const LoginTextField(hintText: "Mail Adresi"),
              const LoginTextField(hintText: "Telefon Numarası"),
              const LoginTextField(hintText: "Kişi Sayısı"),
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
}
