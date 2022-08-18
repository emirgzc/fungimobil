import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            padding: EdgeInsets.all(48.r),
            margin: EdgeInsets.only(top: 900.h),
            color: const Color(0xffF9F9F9),
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bigTitle(),
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
                Padding(
                  padding: EdgeInsets.only(top: 48.h),
                  child: desc(),
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
            commentMenu(context);
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

  Widget bigTitle() {
    return Text(
      "Mantar Avcılığı İçin Gerekli Ekipmanlar",
      style: TextStyle(
        fontSize: 64.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget commentForActivity() {
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

  Widget headerDateandUser(BuildContext context) {
    return Positioned(
      top: 130.h,
      right: 48.w,
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
              "15 Ağustos 2022",
              style: TextStyle(
                color: Color(0xffF4A261),
                fontSize: 13,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                "Ömer Üngör",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
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
