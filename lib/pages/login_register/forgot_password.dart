import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../constants/handle_exceptions.dart';
import '../../constants/style.dart';
import '../../constants/validator.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPassword {
  static String? _mail;
  static String? _pin;
  static String? _newPassword;
  static final GlobalKey<FormState> _forgotPassAskMailFormKey = GlobalKey();
  static final GlobalKey<FormState> _forgotPassFormKey = GlobalKey();

  static Future forgotPassword(BuildContext context) async {
    await _showForgotPassAskMailDialog(context);
  }

  static Future _showForgotPassAskMailDialog(BuildContext context) async {
    // _showForgotPass(context);
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Card(
              margin: const EdgeInsets.all(Style.defaultPadding),
              child: Padding(
                padding: const EdgeInsets.all(Style.defaultPadding),
                child: Form(
                  key: _forgotPassAskMailFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Şifremi unuttum',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: Style.defaultPadding,),
                      Text(
                        'Lütfen hesabınıza tanımlı mail adresini giriniz',
    textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: Style.defaultPadding,),
                      CustomTextField(
                        hintText: 'mail adresi',
                        onChanged: (value) {
                          _mail = value;
                        },
                        validator: Validator.emailValidator,
                      ),
                      // const SizedBox(height: Style.defaultPadding,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.secondaryColor.withOpacity(0.1),
                          elevation: 0
                        ),
                        child: Text(
                          'Doğrulama kodu gönder',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Style.secondaryColor,
                              ),
                        ),
                        onPressed: () async {
                          if (!_forgotPassAskMailFormKey.currentState!.validate()) return;
                          if (_mail == null || _mail!.isEmpty) return;

                          try {
                            await _sendOtpCode(context);

                            EasyLoading.showToast('Doğrulama kodu gönderildi');

                            await _showForgotPass(context);
                            // Navigator.pop(context);
                          } catch (e) {
                            HandleExceptions.handle(exception: e, context: context);
                          }

                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static Future _showForgotPass(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Card(
              margin: const EdgeInsets.all(Style.defaultPadding),
              child: Padding(
                padding: const EdgeInsets.all(Style.defaultPadding),
                child: Form(
                  key: _forgotPassFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Şifre Değiştirme',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: Style.defaultPadding,
                      ),
                      Text(
                        'Lütfen hesabınıza tanımlı mail adresinize gönderdiğimiz kodunu giriniz.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: Style.defaultPadding,
                      ),
                      CustomTextField(
                        hintText: 'doğrulama kodu',
                        initialValue: '',
                        onChanged: (value) {
                          _pin = value;
                        },
                        validator: Validator.requiredTextValidator,
                      ),
                      CustomTextField(
                        hintText: 'yeni parola',
                        initialValue: '',
                        onChanged: (value) {
                          _newPassword = value;
                        },
                        validator: Validator.passwordValidator,
                      ),
                      CustomTextField(
                        hintText: 'yeni parola (tekrar)',
                        initialValue: '',
                        validator: (s) {
                          if (s != _newPassword) {
                            return 'Parolanız tekrarı ile eşleşmiyor';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Style.secondaryColor.withOpacity(0.1),
                          elevation: 0,
                        ),
                        child: Text(
                          'Şifremi değiştir',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Style.secondaryColor,
                              ),
                        ),
                        onPressed: () async {
                          if (!_forgotPassFormKey.currentState!.validate()) return;
                          if (_pin == null || _newPassword == null || _pin!.isEmpty || _newPassword!.isEmpty) return;

                          try {
                            await _changePassword(context);
                          } catch (e) {
                            HandleExceptions.handle(exception: e, context: context);
                          }

                          Navigator.pop(context);
                          EasyLoading.showSuccess('Parolanız değiştirildi!');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static Future _sendOtpCode(BuildContext context) {
    return Provider.of<AuthViewModel>(context, listen: false).forgetPasswordSendOtp(_mail!);
  }

  static Future _changePassword(BuildContext context) {
    return Provider.of<AuthViewModel>(context, listen: false).changePassword(_mail!, _pin!, _newPassword!);
  }
}
