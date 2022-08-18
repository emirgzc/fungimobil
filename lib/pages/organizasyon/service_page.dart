import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizasyonumuz"),
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
              ...List.generate(
                8,
                (index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => detailPop(context),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/fungi2.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Devamını Oku...",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "MANTAR AVCILIĞI EĞİTİMLERİ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Lorem Ipsum has been the industry's standard dummy text the 1500s" *
                                4,
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future detailPop(BuildContext context) {
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
                  "Organizasyon",
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
