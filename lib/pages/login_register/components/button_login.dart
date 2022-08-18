import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonForLogin extends StatelessWidget {
  const ButtonForLogin({Key? key, required this.title, this.onTap})
      : super(key: key);
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 48.h),
        padding: EdgeInsets.symmetric(vertical: 36.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffF4A261),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 64.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
