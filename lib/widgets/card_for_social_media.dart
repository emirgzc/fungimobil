import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/constants/style.dart';

class CardForSocialMedia extends StatelessWidget {
  const CardForSocialMedia({Key? key, required this.iconSvg}) : super(key: key);
  final String iconSvg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 36.h),
      decoration: BoxDecoration(
        boxShadow: [Style.defaultShadow],
        color: Colors.white,
        // border: Border.all(
        //   width: 1,
        //   color: Style.secondaryColor.withOpacity(0.3),
        // ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: SvgPicture.asset(
        iconSvg,
        color: Style.textColor.withOpacity(0.8),
        height: 64.r,
      ),
    );
  }
}
