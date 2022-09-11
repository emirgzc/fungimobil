import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/style.dart';

class CustomIconDialog extends StatelessWidget {
  CustomIconDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.assetIconPath,
    this.iconColor = Colors.white,
    required this.iconBgColor,
    this.actions,
  }) : super(key: key);

  final String title;
  final String content;
  final String assetIconPath;
  final Color iconColor;
  final Color iconBgColor;
  List<IconDialogAction>? actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: iconBgColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(Style.defaultPadding * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      assetIconPath,
                      height: 0.1.sh,
                      width: 0.1.sh,
                      color: iconColor,
                    ),
                    const SizedBox(
                      height: Style.defaultPadding,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Style.defaultPadding,
              vertical: Style.defaultPadding * 2,
            ),
            child: Column(
              children: [
                Text(
                  content,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (actions != null)
                  const SizedBox(
                    height: Style.defaultPadding,
                  ),
                if (actions != null)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (int i = 0; i < actions!.length; i++)
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          ElevatedButton(onPressed: actions![i].onPressed, child: Text(actions![i].text)),
                          if (i != actions!.length - 1) const SizedBox(width: Style.defaultPadding / 2),
                        ]),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconDialogAction {
  const IconDialogAction({required this.text, required this.onPressed, this.backgroundColor});

  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
}
