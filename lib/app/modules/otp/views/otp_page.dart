
import 'package:bookme/app/modules/otp/controller/otp_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/widgets/custom_button.dart';
import 'package:bookme/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../../../common/assets/asset_path.dart';
import '../../../../common/string_constant.dart';

class OtpPage extends GetView<OtpController> {
  OtpPage({Key? key}) : super(key: key);
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetX<OtpController>(
        builder: (_){
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: _size.height * 0.5,
                      child: Center(
                          child: SvgPicture.asset(
                            kOtpVerificationSvg,
                            width: _size.width,
                            height: _size.height * 0.2,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kEnterOtpPassword,style: AppTextStyle.largeTextBold.copyWith(
                                color: AppColors.mallTitleTextColor,
                                fontSize: 17
                              ),),
                              const SizedBox(height: 5.0,),
                              PinInputTextFormField(
                                autoFocus: true,
                                decoration: BoxLooseDecoration(
                                    bgColorBuilder: PinListenColorBuilder(
                                        AppColors.whiteColor, AppColors.textFormFieldBackgroundColor
                                    ),
                                    textStyle: AppTextStyle.largeTextBold.copyWith(
                                        color: AppColors.greyColor
                                    ),
                                  strokeColorBuilder: PinListenColorBuilder(
                                      AppColors.primaryColor, AppColors.whiteColor
                                  ),
                                  gapSpace: 5
                                ),
                                keyboardType: TextInputType.number,
                                controller: controller.pinEditingController,
                                textInputAction: TextInputAction.go,
                                pinLength: 6,
                                onSubmit: (pin) {
                                  // Navigator.of(context).pop();
                                  // signIn(pin);
                                },
                                onChanged: (pin) {
                                  if (pin.length == 6) {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    //code = pin;
                                  }
                                },
                              ),
                              SizedBox(height: _size.height * 0.1,),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: _size.width * 0.6,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomButton(
                                        title: kProceed,
                                        contentPadding: EdgeInsets.symmetric(horizontal: _size.width * 0.2,vertical: 10.0),
                                        onPressed: (){
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          if(controller.formKey.currentState!.validate()){
                                            controller.submitOtp();
                                          }
                                          // Get.toNamed(Routes.HOME);
                                        },
                                      ),
                                      const SizedBox(height: 10,),
                                      GestureDetector(
                                        onTap: (){
                                          controller.sendOtp();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            kResendOtp,
                                            style: AppTextStyle.mediumTextNormal.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: _size.height * 0.5,),
                  ],
                ),
              ),
              Positioned(
                  top: _size.height * 0.05,
                  left: _size.width * 0.02,
                  child: IconButton(
                    iconSize: _size.height * 0.04,
                    icon: Icon(Icons.arrow_back_ios,color: AppColors.primaryColor,),
                    onPressed: (){
                      Get.back();
                    },
                  )
              ),
              if(controller.isLoading.value == OtpLoading.parent)
                const LoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
