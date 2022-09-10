import 'package:flutter/material.dart';

import 'routes.dart';

abstract class CustomException implements Exception {
  abstract String title;
  abstract String subTitle;
  abstract void Function(BuildContext) onDialogDismiss;
  abstract StackTrace? stack;

  CustomException();

  factory CustomException.fromApiMessage(String apiMessage, {StackTrace? stackTrace}) {
    switch (apiMessage) {
      case 'fail.token':
        return LoggedUserNotFoundException(stack: stackTrace);
      case 'mail.or.password.incorrect':
        return ApiException(
            title: 'E-Posta veya Şifre hatalı!',
            subTitle: 'Lütfen bilgilerinizi kontrol edip tekrar deneyin.',
            stack: stackTrace);
    }
    return ApiException(title: 'Bir hata meydana geldi!', subTitle: apiMessage, stack: stackTrace);
  }

  @override
  String toString() {
    return 'CustomException{title: $title, subTitle: $subTitle, onDialogDismiss: $onDialogDismiss}';
  }
}

class LoggedUserNotFoundException extends CustomException {
  LoggedUserNotFoundException({this.stack});

  @override
  String title = 'Giriş yapmış kullanıcı bulunamadı !';

  @override
  String subTitle = 'Giriş yapmış kullanıcı bulunamadı. Lütfen tekrar giriş yapmayı deneyin.';

  @override
  void Function(BuildContext context) onDialogDismiss = (context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false);
  };

  @override
  StackTrace? stack;
}

class ApiException extends CustomException {
  ApiException({
    this.title = 'Sunucuyla iletişimde bir hata oluştu !',
    this.subTitle =
        'Lütfen internet bağlantınızı kontrol edip tekrar deneyin. Yine de bağlantı kuramazsanız mevcut ağınızı değiştirip tekrar deneyiniz.',
    onDialogDismiss,
    this.stack,
  }) {
    this.onDialogDismiss = onDialogDismiss ??
        (context) {
          if (Navigator.canPop(context)) Navigator.pop(context);
        };
  }

  factory ApiException.fromMessage({
    required String title,
    required String message,
    onDialogDismiss,
    StackTrace? stackTrace,
  }) {
    return ApiException(title: title, subTitle: message, stack: stackTrace, onDialogDismiss: onDialogDismiss);
  }

  @override
  String title;

  @override
  String subTitle;

  @override
  late void Function(BuildContext p1) onDialogDismiss;

  @override
  StackTrace? stack;
}

class UnknownException extends CustomException {
  UnknownException({this.stack});

  @override
  String title = 'Hata!';

  @override
  String subTitle = 'Bilinmeyen bir hata oluştu! Lütfen internet bağlantınızı kontrol edip tekrar deneyin.';

  @override
  void Function(BuildContext p1) onDialogDismiss = (context) {
    Navigator.pop(context);
  };

  @override
  StackTrace? stack;
}
