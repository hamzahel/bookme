  import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  ForgotPasswordPage({Key? key}) : super(key: key);

  late Size _size;

  @override
  Widget build(BuildContext context) {

    _size = MediaQuery.of(context).size;
    const vSpace =  SizedBox(height: 20,);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<ForgotPasswordController>(
        builder: (_){
          return SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                Container(
                  height: _size.height * 0.15,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(_size.width * 0.1),
                        bottomRight: Radius.circular(_size.width * 0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0,1),
                          color: AppColors.greyColor.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 2,
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("Forgot Password",style: AppTextStyle.largeTextBold.copyWith(
                            color: AppColors.redColor
                        ),),
                      ),
                      const SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Book Me",style: AppTextStyle.largeTextBold.copyWith(
                            color: AppColors.blackColor
                        ),),
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),

                SizedBox(
                  height: _size.height * 0.4,
                  child: Center(child: Text("Logo",style: AppTextStyle.largeTextBold.copyWith(
                    fontSize: 32,
                    color: AppColors.greyColor
                  ),)),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text("Type your Email Address we will send you a Reset Password link on your Email Address.",style: AppTextStyle.mediumTextNormal.copyWith(
                          color: AppColors.greyColor
                      ),
                        textAlign: TextAlign.center,
                      ),
                      vSpace,
                      CustomTextFieldWidget(
                        controller: controller.emailText,
                        labelText: "Email",
                        maxLine: 1,
                        prefixIcon: Icon(Icons.email,color: AppColors.greyColor,),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 25,),
                      SizedBox(
                        width: _size.width,
                        child: CustomButton(
                          title: 'Send Reset Link',
                          onPressed: (){},
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: _size.height * 0.5,),
              ],
            ),
          );
        },
      ),
    );
  }
}
