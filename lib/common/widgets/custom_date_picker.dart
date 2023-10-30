import 'package:bookme/common/extensions.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_text_style.dart';

class CustomDatePicker extends StatelessWidget {
  CustomDatePicker({Key? key, required this.initialDateTime, required this.onDateTimeChanged, required this.hintText}) : super(key: key);
  final DateTime? initialDateTime;
  final Function(DateTime) onDateTimeChanged;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(hintText!,style: AppTextStyle.smallTextBold.copyWith(
            color: AppColors.blackColor
        ),),
        const SizedBox(height: 5.0,),
        InkWell(
          onTap: () async {
            final dateTime = await showDatePicker(
              context: context,
              initialDate: initialDateTime ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2121),
              builder: (BuildContext context,
                  Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: AppColors.primaryColor,
                    colorScheme: ColorScheme.light(
                        primary: AppColors.primaryColor),
                    buttonTheme: const ButtonThemeData(
                        textTheme:
                        ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );
            if(dateTime != null){
              FocusManager.instance.primaryFocus!.unfocus();
              onDateTimeChanged(dateTime);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12.5),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: AppColors.offWhiteColor2,
                border: Border.all(color: AppColors.primaryColor, width: 0.5)
            ),
            child: Text(
              initialDateTime?.toDateFormat() ?? "YYYY-MM-dd HH:MM",
              style: AppTextStyle.largeTextNormal.copyWith(
                  color: initialDateTime == null ? AppColors.greyColor.withOpacity(0.6) : AppColors.greySubTitleColor
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class CustomDateTimePicker extends StatelessWidget {
  CustomDateTimePicker({
    Key? key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
    required this.hintText
  }) : super(key: key);

  final DateTime? initialDateTime;
  final Function(DateTime) onDateTimeChanged;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(hintText!,style: AppTextStyle.smallTextBold.copyWith(
            color: AppColors.blackColor
        ),),
        const SizedBox(height: 5.0,),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.greyColor300, width: 0.5)
          ),
          child: DateTimePicker(
            type: DateTimePickerType.dateTime,
            enabled: true,
            dateMask: 'yyyy-MM-dd HH:mm',
            initialDate: initialDateTime ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2121),
            dateLabelText: 'Date',
            timeLabelText: "Hour",
            selectableDayPredicate: (date) {
              final currentDateTime = DateTime.now();
              if(date.year < currentDateTime.year){
                return false;
              } else if(date.year == currentDateTime.year && date.month < currentDateTime.month) {
                return false;
              } else if(date.month == currentDateTime.month && date.day < currentDateTime.day){
                return false;
              }
              return true;
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "YYYY-MM-dd HH:MM",
              hintStyle: AppTextStyle.largeTextNormal.copyWith(
                  color: AppColors.greyHintTextColor
              ),
            ),
            onChanged: (value){
              onDateTimeChanged(DateTime.parse(value));
            },
          ),
        ),

      ],
    );
  }
}