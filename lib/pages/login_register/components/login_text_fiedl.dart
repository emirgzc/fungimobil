import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({Key? key, required this.hintText}) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 160.h,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
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
    );
  }
}
