import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,required this.title, this.onPressed,this.textStyle,this.color,this.contentPadding}) : super(key: key);
  final String title;
  final Function()? onPressed;
  final TextStyle? textStyle;
  final Color? color;
  final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: BorderSide(color: color ?? AppColors.primaryColor)),
        color: color ?? AppColors.primaryColor,
        onPressed: onPressed,
        padding: contentPadding ?? const EdgeInsets.only(right: 10,left: 10,top: 10,bottom: 10),
        disabledColor: AppColors.greySubTitleColor500,
        child: Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: textStyle ?? AppTextStyle.largeTextBold.copyWith(
              color: AppColors.whiteColor
          ),
        )
    );
  }
}
