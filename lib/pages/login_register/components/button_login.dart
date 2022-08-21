import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';

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
        margin: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding * (2 / 3),
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Style.secondaryColor,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: Style.bigTitleTextSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
