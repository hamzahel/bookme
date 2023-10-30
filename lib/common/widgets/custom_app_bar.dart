import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar customAppBar({required String title})=> AppBar(
  title: Text(title,style: AppTextStyle.largeTextBold.copyWith(
    color: AppColors.whiteColor
  ),),
  leading: IconButton(
      onPressed: (){
        Navigator.pop(Get.context!);
      },
      icon: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,),
  ),
);