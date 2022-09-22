import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.hintText,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  String hintText;
  String? initialValue;
  Icon? prefixIcon;
  Icon? suffixIcon;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;
  void Function(String?)? onChanged;
  List<TextInputFormatter>?  inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [Style.defaultShadow],
      ),
      margin: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
      height: 160.h,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Style.textColor.withOpacity(0.3),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: Style.defautlHorizontalPadding),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.05),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
        ),
      ),
    );
  }
}
