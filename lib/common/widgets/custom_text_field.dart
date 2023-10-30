import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../app_color.dart';
import '../app_text_style.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget({
    Key? key,
    this.keyboardType,
    this.validator,
    this.maxLine,
    this.onChanged,
    this.controller,
    this.labelText,
    this.icon,
    this.labelStyle,
    this.enabled,
    this.textInputAction,
    this.prefixIcon,
    this.obscureText = false
  }) : super(key: key);
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLine;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? labelText;
  final Widget? icon;
  final TextStyle? labelStyle;
  final bool? enabled;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      maxLines: maxLine ?? null,
      onChanged: onChanged,
      enabled: enabled,
      obscureText: obscureText,
      textInputAction: textInputAction,

      decoration: InputDecoration(
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: AppColor.primaryColor, width: 1.0),
          //   borderRadius: BorderRadius.circular(5.0),
          // ),
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.zero,

          labelText: labelText,
          icon: icon,
          labelStyle: labelStyle ?? AppTextStyle.mediumTextNormal.apply(
            color: AppColors.greyColor.withOpacity(0.8),
          )
      ),
    );
  }
}

class CustomTextFieldWidget2 extends StatelessWidget {
  CustomTextFieldWidget2({
    Key? key,
    this.keyboardType,
    this.validator,
    this.maxLine,
    this.onChanged,
    this.controller,
    this.labelText,
    this.icon,
    this.labelStyle,
    this.enabled,
    this.prefixIconSize,
    this.prefix,
    this.obscureText = false,
    this.textInputAction,
    this.isErrorFound,
    this.radius,
    this.prefixIcon,
    this.enableConstraints = true,
  }) : super(key: key);
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLine;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? labelText;
  final String? icon;
  final TextStyle? labelStyle;
  final bool? enabled;
  final Size? prefixIconSize;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final double? radius;
  final bool? isErrorFound;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool enableConstraints;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      maxLines: maxLine,
      obscureText: obscureText!,
      onChanged: onChanged,
      textInputAction: textInputAction,
      enabled: enabled,
      style: AppTextStyle.mediumTextNormal.copyWith(
          color: AppColors.blackColor
      ),
      decoration: InputDecoration(
        filled: true,
        alignLabelWithHint: true,
        fillColor: AppColors.textFormFieldBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius ?? 10.0),
          borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius ?? 10.0),
          borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius ?? 10.0),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius ?? 10.0),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular( radius ?? 10.0),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        hintText: "Please Enter",
        labelText: labelText,

        labelStyle: AppTextStyle.mediumTextNormal.copyWith(
            color: AppColors.greyColor.withOpacity(0.8),
        ),
        hintStyle: AppTextStyle.mediumTextNormal.copyWith(
            color: AppColors.greyHintTextColor
        ),
        constraints: enableConstraints ? BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: isErrorFound! ? MediaQuery.of(context).size.height * 0.095 : MediaQuery.of(context).size.height * 0.07
        ) : null,
        prefixIcon: prefixIcon,
        prefix: prefix,
        prefixIconConstraints: prefixIconSize != null ?
        BoxConstraints(maxWidth: prefixIconSize!.width,maxHeight: prefixIconSize!.height,) : null
      ),
    );
  }
}

class CustomIntlPhoneField extends StatelessWidget {
  CustomIntlPhoneField({
    Key? key,
    required this.onChanged,
    required this.cursorHeight,
    required this.validator,
    this.radius,
    this.labelText,
    this.isErrorFound,
    this.enabled = true,
    this.initialValue,
    this.initialCountryCode,
  }) : super(key: key);
  final Function(PhoneNumber)? onChanged;
  final double? cursorHeight;
  final double? radius;
  final String? labelText;
  final String? initialCountryCode;
  final String? initialValue;
  final bool? isErrorFound;
  final bool? enabled;
  final FutureOr<String?> Function(PhoneNumber?) validator;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      style: AppTextStyle.mediumTextNormal,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15.0),
          filled: true,
          fillColor: AppColors.textFormFieldBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular( radius ?? 10.0),
            borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( radius ?? 10.0),
            borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( radius ?? 10.0),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( radius ?? 10.0),
            borderSide: BorderSide(color: AppColors.redColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular( radius ?? 10.0),
            borderSide: BorderSide(color: AppColors.redColor),
          ),
          hintText: "Please Enter",
          labelText: labelText,
          labelStyle: AppTextStyle.mediumTextNormal.copyWith(
            color: AppColors.greyColor.withOpacity(0.8),
          ),
          hintStyle: AppTextStyle.mediumTextNormal.copyWith(
              color: AppColors.greyHintTextColor
          ),
          // constraints: BoxConstraints(
          //     maxWidth: MediaQuery.of(context).size.width,
          //     // maxHeight: isErrorFound! ? MediaQuery.of(context).size.height * 0.13 : MediaQuery.of(context).size.height * 0.2
          // ),
      ),
      cursorHeight: cursorHeight,
      initialCountryCode: initialCountryCode ?? 'PK',
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled!,
    );
  }
}

