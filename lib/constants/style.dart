import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Style {
  Style._();

  static const Color primaryColor = Color(0xfff9f9f9);
  static const Color secondaryColor = Color(0xffff8c00);
  static const Color textColor = Color(0xff000000);
  static Color textGreyColor = Colors.black.withOpacity(0.6);
  static const Color dangerColor = Color(0xffc43d4b);
  static const Color succesColor = Color(0xff3e884f);

  static const double defaultPadding = 16.0;
  static double defautlVerticalPadding = 48.h;
  static double defautlHorizontalPadding = 48.w;
  static const double defaultIconSize = 24.0;
  static double defaultRadiusSize = 16.r;
  static EdgeInsets defaultPagePadding = EdgeInsets.all(48.r);
  static double defaultTextSize = 48.sp;
  static double bigTitleTextSize = 64.sp;

  static BoxShadow defaultShadow = BoxShadow(
    blurRadius: 10,
    spreadRadius: 6,
    offset: const Offset(5, 5),
    color: Colors.black.withOpacity(0.06),
  );

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static const shimmerDarkGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFF000000),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
