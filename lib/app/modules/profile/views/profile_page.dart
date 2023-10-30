import 'package:bookme/app/modules/profile/controller/profile_controller.dart';
import 'package:bookme/common/assets/asset_path.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:bookme/common/widgets/custom_button.dart';
import 'package:bookme/common/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../providers/prefrences.dart';
import '../../../routes/app_routes.dart';

class ProfilePage extends GetView<ProfileController> {
  ProfilePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const verticalSpace = SizedBox(height: 10,);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
         return GetBuilder<ProfileController>(
             init: ProfileController(),
             id: "parent_id",
             builder: (_){
               return Stack(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           SizedBox(
                             height: constraints.maxHeight * 0.32,
                             width: constraints.maxWidth,
                             child: Stack(
                               children: [
                                 Positioned(
                                     top: constraints.maxHeight * 0.07,
                                     right: 0,
                                     left: 0,
                                     child: Container(
                                       // height: constraints.maxHeight * 0.3,
                                       padding: const EdgeInsets.all(10),
                                       decoration: BoxDecoration(
                                         borderRadius: const BorderRadius.all(Radius.circular(15)),
                                         color: AppColors.textFormFieldBackgroundColor,

                                       ),
                                       child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           SizedBox(height: constraints.maxHeight * 0.07,),
                                           Text(controller.loginModel?.data?.username ?? "N/A",style: AppTextStyle.xxLargeTextBold,),
                                           // Text(controller.loginModel?.data?.email ?? "N/A",style: AppTextStyle.mediumTextNormal,),
                                           Text(controller.loginModel?.data?.phone ?? "N/A",style: AppTextStyle.mediumTextNormal,),
                                           const SizedBox(height: 10,)
                                         ],
                                       ),
                                     )
                                 ),
                                 Positioned(
                                     top: 0,
                                     right: 0,
                                     left: 0,
                                     child: Container(
                                       color: AppColors.transparent,
                                       child: Align(
                                         alignment: Alignment.center,
                                         child: ClipOval(
                                           child: CachedNetworkImage(
                                             imageUrl: controller.loginModel?.data?.restaurantOwnerImage ?? "",
                                             placeholder: (context, url) => const CircularProgressIndicator(),
                                             errorWidget: (context, url, error) => Container(
                                                 color: AppColors.greyColor.withOpacity(0.1),
                                                 child: Center(child: SvgPicture.asset(
                                                     kProfileSvg,
                                                   width: constraints.maxHeight * 0.15,
                                                   height: constraints.maxHeight * 0.15,
                                                 ))
                                             ),
                                             fit: BoxFit.fill,
                                             width: constraints.maxHeight * 0.15,
                                             height: constraints.maxHeight * 0.15,
                                           ),
                                         ),
                                       ),
                                     )
                                 )
                               ],
                             ),
                           ),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(kPersonal,style: AppTextStyle.largeTextBold,),
                               IconButton(
                                 onPressed: (){
                                   controller.isEditAble = !controller.isEditAble;
                                   controller.update(['parent_id']);
                                 },
                                 icon: Icon( controller.isEditAble ? Icons.clear : Icons.edit),
                                 color: controller.isEditAble ? AppColors.greyColor : AppColors.primaryColor,
                               )
                             ],
                           ),
                           Form(
                             key: _formKey,
                             child: Column(
                               children: [
                                 Obx(()=>CustomTextFieldWidget2(
                                   controller: controller.fullNameText,
                                   labelText: kFullName,
                                   maxLine: 1,
                                   prefixIcon: getSvg(kNameSvg),
                                   // prefixIconSize: const Size(40, 40),
                                   isErrorFound: controller.fullNameErrorFound.value,
                                   textInputAction: TextInputAction.next,
                                   keyboardType: TextInputType.text,
                                   enabled: controller.isEditAble,
                                   validator: (value){
                                     if(value!.trim().isEmpty){
                                       controller.fullNameErrorFound.value = true;
                                       return kFullNameRequired;
                                     }
                                     controller.fullNameErrorFound.value = false;
                                     return null;
                                   },
                                 )),
                                 verticalSpace,
                                 Obx(()=>CustomTextFieldWidget2(
                                   controller: controller.userNameText,
                                   labelText: kUserName,
                                   maxLine: 1,
                                   prefixIcon: getSvg(kUserSvg),
                                   isErrorFound: controller.userNameErrorFound.value,
                                   textInputAction: TextInputAction.next,
                                   keyboardType: TextInputType.text,
                                   enabled: controller.isEditAble,
                                   validator: (value){
                                     if(value!.trim().isEmpty){
                                       controller.userNameErrorFound.value = true;
                                       return kUserNameRequired;
                                     }
                                     controller.userNameErrorFound.value = false;
                                     return null;
                                   },
                                 )),
                                 verticalSpace,
                                 Obx(()=> CustomTextFieldWidget2(
                                   controller: controller.emailText,
                                   labelText: kEmailUserName,
                                   maxLine: 1,
                                   textInputAction: TextInputAction.next,
                                   keyboardType: TextInputType.emailAddress,
                                   isErrorFound: controller.emailErrorFound.value,
                                   prefixIcon: getSvg(kMailSvg),
                                   enabled: controller.isEditAble,
                                 )),
                                 verticalSpace,
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
                                   cursorHeight: constraints.maxHeight * 0.03,
                                   labelText: kPhoneNumber,
                                   initialCountryCode: controller.initialCountryCode,
                                   initialValue: controller.phoneText.replaceAll(controller.initialDialCode, ""),
                                   isErrorFound: controller.phoneTextErrorFound.value,
                                   enabled: controller.isEditAble,
                                 )),
                               ],
                             ),
                           ),
                           if(!controller.isEditAble)
                           const SizedBox(height: 10,),
                           if(!controller.isEditAble)
                           Text(kLanguage,style: AppTextStyle.largeTextBold,),
                           if(!controller.isEditAble)
                           const SizedBox(height: 5,),
                           if(!controller.isEditAble)
                           GetBuilder<ProfileController>(
                             id: "update-language",
                               builder: (_){
                                 return Container(
                                   decoration: BoxDecoration(
                                     borderRadius: const BorderRadius.all(Radius.circular(10)),
                                     color: AppColors.textFormFieldBackgroundColor,
                                   ),
                                   padding: const EdgeInsets.all(10),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                       InkWell(
                                         onTap: () async {
                                           await Preferences.setLang("en-US");
                                           await Get.updateLocale(const Locale('en', 'US'));
                                           controller.update(['update-language']);
                                         },
                                         child: Container(
                                           padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5.0),
                                           decoration: BoxDecoration(
                                               borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                               color: Get.locale!.languageCode == "en" ? AppColors.greenStatusColor : AppColors.whiteColor
                                           ),
                                           child: Text(kEnglish,style: AppTextStyle.mediumTextNormal.copyWith(
                                             color: Get.locale!.languageCode == "en" ? AppColors.whiteColor : AppColors.blackColor
                                           ),),
                                         ),
                                       ),
                                       const SizedBox(height: 25,),
                                       InkWell(
                                         onTap: () async {
                                           await Preferences.setLang("ar-SAR");
                                           await Get.updateLocale(const Locale('ar', 'SAR'));
                                           controller.update(['update-language']);
                                         },
                                         child: Container(
                                           padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5.0),
                                           decoration: BoxDecoration(
                                               borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                               color: Get.locale!.languageCode == "ar" ? AppColors.greenStatusColor : AppColors.whiteColor
                                           ),
                                           child: Text(kArabic,style: AppTextStyle.mediumTextNormal.copyWith(
                                               color: Get.locale!.languageCode == "ar" ? AppColors.whiteColor : AppColors.blackColor
                                           ),),
                                         ),
                                       ),
                                     ],
                                   ),
                                 );
                               }
                           ),
                           const SizedBox(height: 25,),
                           InkWell(
                             onTap: () async {
                               if(controller.isEditAble){
                                 FocusScope.of(context).requestFocus(FocusNode());
                                 if(_formKey.currentState!.validate()){
                                   controller.isEditAble = false;
                                   controller.updateProfile();
                                 }
                               } else {
                                 await Preferences.deleteAuth();
                                 Get.offAllNamed(Routes.LOGIN);
                               }
                             },
                             child: Container(
                               decoration: BoxDecoration(
                                   color: controller.isEditAble ? AppColors.greenStatusColor : AppColors.primaryColor,
                                   borderRadius: const BorderRadius.all(Radius.circular(100)),
                                   boxShadow: [
                                     BoxShadow(
                                         color: AppColors.greyColor.withOpacity(0.2),
                                         offset: const Offset(0,1),
                                         spreadRadius: 0.5,
                                         blurRadius: 0.5
                                     )
                                   ]
                               ),
                               padding: EdgeInsets.symmetric(vertical: controller.isEditAble ? 10 : 7.5,horizontal: 25),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 mainAxisSize: controller.isEditAble ? MainAxisSize.max : MainAxisSize.min,
                                 children: [
                                   if(!controller.isEditAble)
                                   Icon(Icons.logout,size: 20,color: AppColors.whiteColor,),
                                   if(!controller.isEditAble)
                                   const SizedBox(width: 5.0,),
                                   Text( controller.isEditAble ? kUpdate : kLogout,style: AppTextStyle.mediumTextBold.copyWith(
                                       color: AppColors.whiteColor
                                   ),)
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(height: constraints.maxHeight * 0.4,),
                         ],
                       ),
                     ),
                   ),
                   Obx((){
                     if(controller.isLoading.value == ProfileLoading.parent){
                       return const LoadingWidget();
                     }
                     return Container();
                   })
                 ],
               );
             }
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

}
