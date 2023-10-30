import 'package:bookme/app/modules/restaurants/controllers/reserve_controller2.dart';
import 'package:bookme/common/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/string_constant.dart';
import '../../../../common/widgets/custom_button.dart';
import '../models/table_available_model.dart';

class WaitingDialog extends GetView<ReserveController2> {

  WaitingDialog({Key? key,required this.size,required this.tables}) : super(key: key);
  Size? size;
  Tables? tables;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: size!.width,
        height: size!.height * 0.4,
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final vSpace = SizedBox(height: constraints.maxHeight * 0.02,);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                    child: Center(
                        child: CustomRichText(
                          textAlign: TextAlign.center,
                            label: "$kDoYouWantToAdd ",
                            labelTextStyle: AppTextStyle.mediumTextNormal,
                            children: [
                              TextSpan(
                                text: "$kTableNo ${tables!.tableNo!} ",
                                style: AppTextStyle.mediumTextBold,
                              ),
                              TextSpan(
                                text: kInWaitingList,
                                style: AppTextStyle.mediumTextNormal,
                              ),
                            ]
                        )
                    )
                ),
                SizedBox(height: constraints.maxHeight * 0.04,),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                          color: AppColors.whiteColor,
                          textStyle: AppTextStyle.smallTextBold.copyWith(
                              color: AppColors.blackColor
                          ),
                          title: kCancel, onPressed:() { Get.back(); }
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: CustomButton(
                          color: AppColors.greenColor,
                          textStyle: AppTextStyle.smallTextBold.copyWith(
                              color: AppColors.whiteColor
                          ),
                          title: kAdd, onPressed:() {
                        controller.addWaiting(tables!);
                      }
                      ),
                    ),

                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}