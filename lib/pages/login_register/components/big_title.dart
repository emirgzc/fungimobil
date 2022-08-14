import 'package:flutter/material.dart';

class BigTitle extends StatelessWidget {
  const BigTitle({Key? key, required this.title, required this.size})
      : super(key: key);
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: const Color(0xffF4A261),
      ),
    );
  }
}
