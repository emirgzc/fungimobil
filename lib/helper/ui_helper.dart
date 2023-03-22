import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';

enum UIType { negative, positive, info, warning }

extension UITypeExtension on UIType {
  Color getBackgroundColor() {
    switch (this) {
      case UIType.negative:
        return Style.dangerColor;
      case UIType.positive:
        return Style.succesColor;
      case UIType.info:
        return Colors.blueAccent;
      case UIType.warning:
        return Style.secondaryColor;
    }
  }
}

class UIHelper {
  static showSnackBar({
    required String message,
    required UIType type,
    required BuildContext context,
    bool useDialog = false,
  }) {
    if (useDialog) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            // shape: const RoundedRectangleBorder(),
            alignment: Alignment.bottomCenter,
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            insetAnimationCurve: Curves.linearToEaseOut,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: type.getBackgroundColor(),
              clipBehavior: Clip.none,
              shape: const RoundedRectangleBorder(),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(Style.defaultPadding),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ).timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          Navigator.maybePop(context);
        },
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type.getBackgroundColor(),
        content: Text(
          message,
          style: Theme.of(context).snackBarTheme.contentTextStyle?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
