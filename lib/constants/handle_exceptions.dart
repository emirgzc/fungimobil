import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import '../widgets/dialogs/error_dialog.dart';
import 'exceptions.dart';

class HandleExceptions {
  HandleExceptions._();

  static handle(
      {required dynamic exception, required BuildContext context, void Function(BuildContext)? onDismiss}) async {
    try {
      // FirebaseCrashlytics.instance.recordError(exception, StackTrace.current);
    } catch (e) {
      debugPrint('FirebaseCrashlytics.recordError fail!!!');
    }
    debugPrint('ERROR::: ' + exception.toString());
    if (exception is SocketException) exception = ApiException(onDialogDismiss: (context) {});
    if (exception is! CustomException) {
      exception = UnknownException();
    }
    if (exception is LoggedUserNotFoundException) {
      showErrorDialog(
        context,
        exception.title,
        exception.subTitle,
        exception.onDialogDismiss,
      );
    } else if (exception is ApiException) {
      showErrorDialog(
        context,
        exception.title,
        exception.subTitle,
        onDismiss ??
            (context) {
              Navigator.pop(context);
            },
      );
    } else {
      debugPrint('Bilinmeyen bir hata meydana geldi!');
      showErrorDialog(
        context,
        exception.title,
        exception.subTitle,
        onDismiss ??
            (context) {
              Navigator.pop(context);
            },
      );
    }
  }

  static showErrorDialog(
    BuildContext context,
    String title,
    String message,
    void Function(BuildContext) onDismiss,
  ) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Column(
    //       children: [
    //         Text(title),
    //         Text(message),
    //       ],
    //     ),
    //     backgroundColor: Colors.yellow,
    //     duration: Duration(seconds: 3),
    //     behavior: SnackBarBehavior.floating,
    //   ),
    // );
    // onDismiss(context);

    showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(
            title: title,
            content: message,
            onDismiss: onDismiss,
          );
        }).whenComplete(() {
          onDismiss(context);
        });
  }
}
