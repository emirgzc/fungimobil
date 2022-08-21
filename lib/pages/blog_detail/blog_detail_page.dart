import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/card_for_social_media.dart';

class BlogDetailPage extends StatelessWidget {
  const BlogDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: blogBody(context),
    );
  }

  Widget blogBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            height: 900.h,
            width: double.infinity,
            child: Image.asset(
              'assets/images/r.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          arrowBack(context),

          headerDateandUser(context),
          // buttonForRecord(),
          Container(
            padding: Style.defaultPagePadding,
            margin: EdgeInsets.only(top: 900.h),
            color: Style.primaryColor,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bigTitle(),
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
                Padding(
                  padding: EdgeInsets.only(top: Style.defautlVerticalPadding),
                  child: desc(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Style.defautlVerticalPadding,
                  ),
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
            commentMenu(context);
          },
          child: Text(
            "Tüm Yorumlar",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 40.sp,
            ),
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
        color: Style.textGreyColor,
      ),
    );
  }

  Widget bigTitle() {
    return Text(
      "Mantar Avcılığı İçin Gerekli Ekipmanlar",
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget commentForActivity() {
    return Row(
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
          width: 800.w,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Yorum Yap",
              hintStyle: TextStyle(
                color: Style.textColor.withOpacity(0.3),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Style.defautlHorizontalPadding,
              ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Style.textColor.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
            ),
          ),
        ),
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

  Widget headerDateandUser(BuildContext context) {
    return Positioned(
      top: 130.h,
      right: 48.w,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 2,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "15 Ağustos 2022",
              style: TextStyle(
                color: const Color(0xffF4A261),
                fontSize: 40.sp,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "Ömer Üngör",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget arrowBack(BuildContext context) {
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

  Future commentMenu(BuildContext context) {
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
                    horizontal: Style.defautlHorizontalPadding / 2),
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
                                    fontSize: Style.defaultTextSize,
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
}
