import 'package:bookme/app/providers/prefrences.dart';
import 'package:bookme/app/services/settings_service.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/root_controller.dart';

class RootPage extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
        builder: (_){
          return Scaffold(
            body: !controller.isLangPreferencesExist ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Please Select Language",style: AppTextStyle.largeTextBold,),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _language(title: "English",
                        color: controller.selectedLang == "en" ? AppColors.primaryColor : AppColors.whiteColor,
                        onTap: () async {
                          controller.selectedLang = "en";
                          controller.update();
                          await Preferences.setLang("en-US");
                          Get.updateLocale(const Locale('en', 'US'));
                          controller.preferences();
                        }
                    ),
                    const SizedBox(width: 15,),
                    _language(title: "Arabic",
                        color: controller.selectedLang == "ar" ? AppColors.primaryColor : AppColors.whiteColor,
                        onTap: () async {
                          controller.selectedLang = "ar";
                          controller.update();
                          await Preferences.setLang("ar-SAR");
                          Get.updateLocale(const Locale('ar', 'SAR'));
                          controller.preferences();
                        }
                    ),
                  ],
                ),
              ],
            ) : const LoadingWidget(),
          );
        }
    );
  }

  Widget _language({required String title,required Color color,required Function() onTap,}){
    return Flexible(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: color,
                border: Border.all(color: color == AppColors.whiteColor ? AppColors.blackColor : AppColors.whiteColor)
            ),
            child: Text(title,style: AppTextStyle.smallTextNormal.copyWith(
                color: color == AppColors.whiteColor ? AppColors.blackColor : AppColors.whiteColor
            ),),
          ),
        )
    );
  }

}
