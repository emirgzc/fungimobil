import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.hintText}) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
      height: 160.h,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Style.textColor.withOpacity(0.3),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: Style.defautlHorizontalPadding),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
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
    );
  }
}
