import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_text_style.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({Key? key, required this.label, this.labelTextStyle, required this.children, this.textAlign = TextAlign.start}) : super(key: key);
  final String label;
  final TextStyle? labelTextStyle;
  final List<TextSpan> children;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
          text: label,
          style: labelTextStyle ?? AppTextStyle.smallTextNormal.copyWith(
            color: AppColors.greyColor.withOpacity(0.8),
          ),
          children: children
      ),
    );
  }
}
