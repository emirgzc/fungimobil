import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.isMinimal = false}) : super(key: key);

  final bool isMinimal;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.4),
      child: Center(
        child: LoadingAnimationWidget.stretchedDots(color: Style.secondaryColor, size: isMinimal ? 70.r : 100.r),/*CircularProgressIndicator(
          color: Style.secondaryColor,
        ),*/
      ),
    );
  }
}
