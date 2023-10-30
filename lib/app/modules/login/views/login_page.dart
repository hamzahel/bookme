import 'package:bookme/app/modules/login/controller/login_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:bookme/common/widgets/custom_rich_text.dart';
import 'package:bookme/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/assets/asset_path.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../routes/app_routes.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetX<LoginController>(
        builder: (_) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        kLogoSvg,
                        height: _size.height * 0.13,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        kWelcome,
                        style: AppTextStyle.xLargeTextBold.copyWith(
                            color: AppColors.primaryColor, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _size.height * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            Obx(() => CustomIntlPhoneField(
                                  onChanged: (phone) {
                                    controller.phoneText = phone.completeNumber;
                                  },
                                  validator: (value) {
                                    if (value?.completeNumber == null ||
                                        value!.completeNumber.isEmpty) {
                                      controller.phoneTextErrorFound.value =
                                          true;
                                      return kPhoneNumberRequired;
                                    }
                                    controller.phoneTextErrorFound.value =
                                        false;
                                    return null;
                                  },
                                  cursorHeight: _size.height * 0.03,
                                  labelText: kPhoneNumber,
                                  isErrorFound:
                                      controller.phoneTextErrorFound.value,
                                )),
                            SizedBox(
                              height: _size.height * 0.05,
                            ),
                            SizedBox(
                              width: _size.width * 0.6,
                              child: CustomButton(
                                title: kLogin,
                                onPressed: () {
                                  debugPrint("you press login button");
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.login();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: _size.height * 0.05,
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Get.toNamed(Routes.SIGNUP);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomRichText(
                                    label: "$kDontHaveAccount ",
                                    labelTextStyle:
                                        AppTextStyle.mediumTextNormal.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: kRegisterNow.tr,
                                          style: AppTextStyle.mediumTextNormal
                                              .copyWith(
                                            color: AppColors.redColor,
                                          )),
                                    ]),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              if (controller.isLoading.value == LoginLoading.parent)
                const LoadingWidget()
            ],
          );
        },
      ),
    );
  }
}
