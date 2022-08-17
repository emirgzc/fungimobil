import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MisyonPage extends StatelessWidget {
  const MisyonPage({Key? key}) : super(key: key);

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
              'assets/images/fungi1.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          arrowBack(context),
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
                  padding: EdgeInsets.only(top: 48.h, bottom: 48.h),
                  child: desc(),
                ),
              ],
            ),
          ),
        ],
      ),
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
      "Misyonumuz",
      style: TextStyle(
        fontSize: 64.sp,
        fontWeight: FontWeight.w500,
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
}
