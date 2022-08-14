import 'package:flutter/material.dart';

class DescTitle extends StatelessWidget {
  const DescTitle({Key? key, required this.title, required this.size})
      : super(key: key);
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
