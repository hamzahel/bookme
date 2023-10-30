import 'dart:io';
import 'package:bookme/app/modules/sign-up/controller/signup_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../common/assets/asset_path.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/loading_widget.dart';

class SignUpPage extends GetView<SignUpController> {
  SignUpPage({Key? key}) : super(key: key);

  late Size _size;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    _size = MediaQuery.of(context).size;
    const vSpace =  SizedBox(height: 10,);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetX<SignUpController>(
        builder: (_){
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: _size.width,
                      height: _size.height * 0.3,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                  kLogoSvg,
                                  // width: _size.width * 0.1,
                                  height: _size.height * 0.125,
                              ),
                              SizedBox(height: _size.height * 0.02,),
                              Text(kWelcome,style: AppTextStyle.xLargeTextBold.copyWith(
                                color: AppColors.primaryColor,
                                fontSize: 22
                              ),
                              textAlign: TextAlign.center,
                              ),
                              SizedBox(height: _size.height * 0.03,),
                            ],
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
                          )
                        ],
                      ),
                    ),

                    ClipOval(
                      child:  Container(
                        width: _size.height * 0.15,
                        height: _size.height * 0.15,
                        color: AppColors.greyColor.withOpacity(0.1),
                        child: Stack(
                          children: [
                            Obx((){
                              final file = controller.imageFile.value;
                              return Center(
                                child: file.path.isEmpty ? SvgPicture.asset(
                                  kProfileSvg,
                                  width: _size.height * 0.15,
                                  height: _size.height * 0.15,
                                ) :
                                Image(
                                  width: _size.height * 0.15,
                                  height: _size.height * 0.15,
                                    image: FileImage(File(file.path)),
                                    fit: BoxFit.fill,
                                ),
                              );
                            }),
                            Positioned(
                              right: _size.width * 0.02,
                                bottom: _size.height * 0.015,
                                child: ClipOval(
                                  child: Container(
                                    color: AppColors.greenColor,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: _size.width * 0.08,
                                      constraints: BoxConstraints(maxWidth: _size.width * 0.1,minHeight: _size.height * 0.03),
                                      icon: Icon(Icons.add,color: AppColors.whiteColor,),
                                      onPressed: (){
                                        _choosePhotoBottomSheet(context);
                                      },
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),


                    SizedBox(height: _size.height * 0.03,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Obx(()=>CustomTextFieldWidget2(
                              controller: controller.fullNameText,
                              labelText: kFullName,
                              maxLine: 1,
                              prefixIcon: getSvg(kNameSvg),
                              isErrorFound: controller.fullNameErrorFound.value,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: (value){
                                if(value!.trim().isEmpty){
                                  controller.fullNameErrorFound.value = true;
                                  return kFullNameRequired;
                                }
                                controller.fullNameErrorFound.value = false;
                                return null;
                              },
                            )),
                            vSpace,
                            Obx(()=>CustomTextFieldWidget2(
                              controller: controller.userNameText,
                              labelText: kUserName,
                              maxLine: 1,
                              prefixIcon: getSvg(kUserSvg),
                              isErrorFound: controller.userNameErrorFound.value,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              validator: (value){
                                if(value!.trim().isEmpty){
                                  controller.userNameErrorFound.value = true;
                                  return kUserNameRequired;
                                }
                                controller.userNameErrorFound.value = false;
                                return null;
                              },
                            )),
                            vSpace,
                            Obx(()=>CustomIntlPhoneField(
                              onChanged: (phone) {
                                controller.phoneText = phone.completeNumber;
                              },
                              validator: (value){
                                if(value?.completeNumber == null || value!.completeNumber.isEmpty){
                                  controller.phoneTextErrorFound.value = true;
                                  return kPhoneNumberRequired;
                                }
                                controller.phoneTextErrorFound.value = false;
                                return null;
                              },
                              cursorHeight: _size.height * 0.03,
                              labelText: kPhoneNumber,
                              isErrorFound: controller.phoneTextErrorFound.value,
                            )),
                            vSpace,
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.greyHintTextColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(Radius.circular(5.0))
                              ),
                              child: Obx(()=>Row(
                                children: [
                                  Flexible(
                                      child: Text("$kGender: ",style: AppTextStyle.largeTextBold,)
                                  ),
                                  SizedBox(width: _size.width * 0.02,),
                                  _gender(title: kMale, color: controller.gender.value == kMale ? AppColors.greenTitleColor : AppColors.whiteColor, onTap: (){
                                    controller.gender.value = kMale;
                                  }),
                                  SizedBox(width: _size.width * 0.015,),
                                  _gender(title: kFemale, color: controller.gender.value == kFemale ? AppColors.greenTitleColor : AppColors.whiteColor, onTap: (){
                                    controller.gender.value = kFemale;
                                  }),
                                  SizedBox(width: _size.width * 0.015,),
                                  _gender(title: kOther, color: controller.gender.value == kOther ? AppColors.greenTitleColor : AppColors.whiteColor, onTap: (){
                                    controller.gender.value = kOther;
                                  }),
                                ],
                              )),
                            ),
                            vSpace,
                            GestureDetector(
                              onTap: (){
                                controller.isReadTermsAndCondition.value = !controller.isReadTermsAndCondition.value;
                              },
                              child: Obx(()=>Row(
                                children: [
                                  Checkbox(
                                      value: controller.isReadTermsAndCondition.value,
                                      onChanged: (value){
                                        controller.isReadTermsAndCondition.value = !controller.isReadTermsAndCondition.value;
                                      }),
                                  const SizedBox(width: 10,),
                                  Flexible(
                                    child: Text(kIHaveRead,
                                      style: AppTextStyle.smallTextNormal,),
                                  )
                                ],
                              )),
                            ),
                            vSpace,
                            SizedBox(
                              width: _size.width * 0.6,
                              child: CustomButton(
                                title: kRegister,
                                onPressed: (){
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  if(_formKey.currentState!.validate()){
                                    if(controller.isReadTermsAndCondition.value){
                                      controller.signUp();
                                    } else {
                                      controller.errorSnackBar(kPleaseRead);
                                    }
                                  }
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: _size.height * 0.5,),
                  ],
                ),
              ),
              if(controller.isLoading.value == SignUpLoading.parent)
                const LoadingWidget()
            ],
          );
        },
      ),
    );
  }

  getSvg(String svg){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 15),
      child: SvgPicture.asset(
        svg,
      ),
    );
  }

  Widget _gender({required String title,required Color color,required Function() onTap,}){
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

  void _choosePhotoBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: ((builder) =>
            Container(
              height: _size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    kChoosePhoto,
                    style: AppTextStyle.largeTextBold
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                          IconButton(onPressed: () async {
                            Get.back();
                            PickedFile?
                            pickedFile = await ImagePicker().getImage(
                              source: ImageSource.camera,
                              maxWidth: 1800,
                              maxHeight: 1800,);
                            if (pickedFile != null) {
                              controller.imageFile.value = File(pickedFile.path);
                            }
                          },
                          icon: Icon(Icons.camera,size: _size.width * 0.1,),
                          constraints: BoxConstraints(maxWidth: _size.width * 0.2, maxHeight:  _size.height * 0.2),
                          ),
                          IconButton(onPressed: () async {
                            Get.back();
                            PickedFile?
                            pickedFile = await ImagePicker().getImage(
                              source: ImageSource.gallery,
                              maxWidth: 1800,
                              maxHeight: 1800,);
                            if (pickedFile != null) {
                              controller.imageFile.value = File(pickedFile.path);
                            }
                          },
                            icon: Icon(Icons.image,size: _size.width * 0.1,),
                            constraints: BoxConstraints(maxWidth: _size.width * 0.2, maxHeight:  _size.height * 0.2),
                          ),
                          IconButton(onPressed: () async {
                            Get.back();
                            controller.imageFile.value = File("");
                          },
                            icon: Icon(Icons.delete,size: _size.width * 0.1,
                                color: controller.imageFile.value.path.isNotEmpty ? AppColors.blackColor : AppColors.greyColor.withOpacity(0.6),),
                            constraints: BoxConstraints(maxWidth: _size.width * 0.2, maxHeight:  _size.height * 0.2),
                          ),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }

}
