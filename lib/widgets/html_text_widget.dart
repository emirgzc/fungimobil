import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlTextWidget extends StatelessWidget {
  HtmlTextWidget({
    Key? key,
    required this.content,
    this.maxContentLength,
    this.fontSize,
    this.color,
    this.loadingText,
    this.isLoading = false,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);

  String? content;
  final int? maxContentLength;
  final double? fontSize;
  final Color? color;
  final String? loadingText;
  bool isLoading;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && maxContentLength != null) {
      content =
          '${content!.substring(0, min(maxContentLength!, content!.length))}...';
    }
    return HtmlWidget(
      isLoading ? loadingText! : content!,
      textStyle: TextStyle(
        fontSize: fontSize,
        color: color,
        overflow: overflow,
      ),
    );
  }
}
