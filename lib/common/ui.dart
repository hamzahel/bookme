import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/html_parser.dart';
// import 'package:flutter_html/style.dart';
import 'package:get/get.dart';

class Ui {
  static GetSnackBar SuccessSnackBar({String? title, String? message}) {
    title ??= kSuccess;
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title, style: AppTextStyle.mediumTextBold.copyWith(
          color: AppColors.whiteColor
      )),
      messageText: Text(message!, style: AppTextStyle.mediumTextNormal.copyWith(
          color: AppColors.whiteColor
      )),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.greenTitleColor,
      icon: Icon(Icons.check_circle_outline, size: 32, color: AppColors.whiteColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 2),
    );
  }

  static GetSnackBar ErrorSnackBar({String? title, String? message}) {
    title ??= kError;
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title, style: AppTextStyle.mediumTextBold.copyWith(
        color: AppColors.whiteColor
      )),
      messageText: Text(message!, style: AppTextStyle.mediumTextNormal.copyWith(
          color: AppColors.whiteColor
      )),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.redColor,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: AppColors.whiteColor),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 1),
    );
  }

  static GetSnackBar defaultSnackBar({String? title, String? message}) {
    title ??= kAlert;
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr, style: AppTextStyle.mediumTextBold.copyWith(
          color: AppColors.whiteColor
      )),
      messageText: Text(message!, style: AppTextStyle.mediumTextNormal.copyWith(
          color: AppColors.whiteColor
      )),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: AppColors.blackColor,
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: Icon(Icons.warning_amber_rounded, size: 32, color: AppColors.whiteColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: Duration(seconds: 1),
    );
  }

  static Color parseColor(String? hexCode, {double? opacity}) {
    try {
      return Color(int.parse(hexCode!.replaceAll("#", "0xFF"))).withOpacity(opacity ?? 1);
    } catch (e) {
      return Color(0xFFCCCCCC).withOpacity(opacity ?? 1);
    }
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  static BoxDecoration getBoxDecoration({Color? color, double? radius, Border? border, Gradient? gradient}) {
    return BoxDecoration(
      color: color ?? Get.theme.primaryColor,
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      boxShadow: [
        BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
      ],
      border: border ?? Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
      gradient: gradient,
    );
  }

  static InputDecoration getInputDecoration({String hintText = '', String? errorText, IconData? iconData, Widget? suffixIcon, Widget? suffix}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.caption,
      prefixIcon: iconData != null ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14) : SizedBox(),
      prefixIconConstraints: iconData != null ? BoxConstraints.expand(width: 38, height: 38) : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }

  /*static Html applyHtml(String? html, {TextStyle? style}) {
    return Html(
      data: html!.replaceAll('\r\n', ''),
      customRender: {
        "p": (RenderContext context, Widget child) {
          return Text(
            context.tree.element!.text,
            style: style == null ? Get.textTheme.bodyText1!.merge(TextStyle(fontSize: 11)) : style.merge(TextStyle(fontSize: 11)),
          );
        },
      },
      style: {
        "*": Style(
          color: style == null ? Get.theme.hintColor : style.color,
          fontSize: style == null ? FontSize(16.0) : FontSize(style.fontSize),
          display: Display.INLINE_BLOCK,
          fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
          width: Get.width,
        ),
        "li": Style(
          lineHeight: LineHeight.normal,
          listStylePosition: ListStylePosition.OUTSIDE,
          fontSize: style == null ? FontSize(14.0) : FontSize(style.fontSize),
          display: Display.BLOCK,
        ),
        "h4,h5,h6": Style(
          fontSize: style == null ? FontSize(16.0) : FontSize(style.fontSize! + 2),
        ),
        "h1,h2,h3": Style(
          lineHeight: LineHeight.number(2),
          fontSize: style == null ? FontSize(18.0) : FontSize(style.fontSize! + 4),
        ),
        "br": Style(
          height: 0,
        ),
      },
    );
  }

  static Html removeHtml(String? html, {TextStyle? style}) {
    return Html(
      data: html!.replaceAll('\r\n', ''),
      customRender: {
        "p": (RenderContext context, Widget child) {
          return Text(
            context.tree.element!.text,
            style: style == null ? Get.textTheme.bodyText1!.merge(TextStyle(fontSize: 11)) : style.merge(TextStyle(fontSize: 11)),
          );
        },
      },
      style: {
        "*": Style(
          color: style == null ? Get.theme.hintColor : style.color,
          fontSize: style == null ? FontSize(11.0) : FontSize(style.fontSize),
          display: Display.INLINE_BLOCK,
          fontWeight: style == null ? FontWeight.w300 : style.fontWeight,
          width: Get.width,
        ),
        "br": Style(
          height: 0,
        ),
      },
    );
  }*/

  static BoxFit getBoxFit(String boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static AlignmentDirectional getAlignmentDirectional(String alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  static CrossAxisAlignment getCrossAxisAlignment(String textPosition) {
    switch (textPosition) {
      case 'top_start':
        return CrossAxisAlignment.start;
      case 'top_center':
        return CrossAxisAlignment.center;
      case 'top_end':
        return CrossAxisAlignment.end;
      case 'center_start':
        return CrossAxisAlignment.center;
      case 'center':
        return CrossAxisAlignment.center;
      case 'center_end':
        return CrossAxisAlignment.center;
      case 'bottom_start':
        return CrossAxisAlignment.start;
      case 'bottom_center':
        return CrossAxisAlignment.center;
      case 'bottom_end':
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }

  static bool isDesktop(BoxConstraints constraint) {
    return constraint.maxWidth >= 1280;
  }

  static bool isTablet(BoxConstraints constraint) {
    return constraint.maxWidth >= 768 && constraint.maxWidth <= 1280;
  }

  static bool isMobile(BoxConstraints constraint) {
    return constraint.maxWidth < 768;
  }

  static double col12(BoxConstraints constraint, {double desktopWidth = 1280, double tabletWidth = 768, double mobileWidth = 480}) {
    if (isMobile(constraint)) {
      return mobileWidth;
    } else if (isTablet(constraint)) {
      return tabletWidth;
    } else {
      return desktopWidth;
    }
  }

  static double col9(BoxConstraints constraint, {double desktopWidth = 1280, double tabletWidth = 768, double mobileWidth = 480}) {
    if (isMobile(constraint)) {
      return mobileWidth * 3 / 4;
    } else if (isTablet(constraint)) {
      return tabletWidth * 3 / 4;
    } else {
      return desktopWidth * 3 / 4;
    }
  }

  static double col8(BoxConstraints constraint, {double desktopWidth = 1280, double tabletWidth = 768, double mobileWidth = 480}) {
    if (isMobile(constraint)) {
      return mobileWidth * 2 / 3;
    } else if (isTablet(constraint)) {
      return tabletWidth * 2 / 3;
    } else {
      return desktopWidth * 2 / 3;
    }
  }

  static double col6(BoxConstraints constraint, {double desktopWidth = 1280, double tabletWidth = 768, double mobileWidth = 480}) {
    if (isMobile(constraint)) {
      return mobileWidth / 2;
    } else if (isTablet(constraint)) {
      return tabletWidth / 2;
    } else {
      return desktopWidth / 2;
    }
  }

  static double col4(BoxConstraints constraint, {double desktopWidth = 1280, double tabletWidth = 768, double mobileWidth = 480}) {
    if (isMobile(constraint)) {
      return mobileWidth * 1 / 3;
    } else if (isTablet(constraint)) {
      return tabletWidth * 1 / 3;
    } else {
      return desktopWidth * 1 / 3;
    }
  }

  static double col3(BoxConstraints constraint, {double desktopWidth = 1280, double tabletWidth = 768, double mobileWidth = 480}) {
    if (isMobile(constraint)) {
      return mobileWidth * 1 / 4;
    } else if (isTablet(constraint)) {
      return tabletWidth * 1 / 4;
    } else {
      return desktopWidth * 1 / 4;
    }
  }
}

const double horizontalPadding = 25.0;
