import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_text_style.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    Key? key,
    required this.hintText,
    required this.list,
    required this.onChanged,
    this.initialValue
  }) : super(key: key);
  final String hintText;
  final List<String> list;
  final Function(String?) onChanged;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: AppTextStyle.smallTextNormal.copyWith(
              color: AppColors.primaryColor
          ),
        ),
        DropdownButton<String>(
          isExpanded: true,
          value: initialValue,
          hint: Text(initialValue!),
          items: list.map((String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          )).toList(),
          onChanged: onChanged,
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
        ),
      ],
    );
  }

}