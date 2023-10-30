import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyle {
  /// XX large text style
  static TextStyle get xxLargeTextBold => Get.theme.textTheme.headline1!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get xxLargeTextNormal => Get.theme.textTheme.headline1!;
  /// X large text style
  static TextStyle get xLargeTextBold => Get.theme.textTheme.headline2!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get xLargeTextNormal => Get.theme.textTheme.headline2!;
  /// Large text style
  static TextStyle get largeTextBold => Get.theme.textTheme.headline3!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get largeTextNormal => Get.theme.textTheme.headline3!;
  /// Medium text style
  static TextStyle get mediumTextBold => Get.theme.textTheme.headline4!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get mediumTextNormal => Get.theme.textTheme.headline4!;
  /// Small text style
  static TextStyle get smallTextBold => Get.theme.textTheme.headline5!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get smallTextNormal => Get.theme.textTheme.headline5!;
  /// X small text style
  static TextStyle get xSmallTextBold => Get.theme.textTheme.headline6!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get xSmallTextNormal => Get.theme.textTheme.headline6!;
  /// XX small text style
  static TextStyle get xxSmallTextBold => Get.theme.textTheme.caption!.copyWith(
    fontWeight: FontWeight.bold,
  );
  static TextStyle get xxSmallTextNormal => Get.theme.textTheme.caption!;

}