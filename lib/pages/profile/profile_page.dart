import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        title: const Text("Profil Sayfası"),
        centerTitle: true,
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(48.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => editPop(context),
                    child: Container(
                      padding: EdgeInsets.all(32.r),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffF4A261).withOpacity(0.7),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(100.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color(0xffF4A261).withOpacity(0.7),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "E G",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Muhammed Emir Gözcü",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.mail_outline_rounded,
                        size: 14,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16, left: 4),
                        child: Text("emirgzc4@gmail.com"),
                      ),
                      Icon(
                        Icons.phone_android_outlined,
                        size: 14,
                      ),
                      Text("0 555 555 55 55"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
                          4,
                      style: TextStyle(
                        fontSize: 44.sp,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Etkinlik Yorumlarım",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("12 Yorum"),
                                  Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
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

  Future editPop(BuildContext context) {
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
                  "Profil Güncelleme",
                  style: TextStyle(
                    fontSize: 62.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "Lorem Ipsum has been the industry's standard dummy text the 1500s" *
                    4,
              ),
            ],
          ),
        );
      },
    );
  }
}
