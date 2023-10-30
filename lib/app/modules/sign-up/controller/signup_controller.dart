import 'dart:io';

import 'package:bookme/app/models/lang_model.dart';
import 'package:bookme/app/routes/app_routes.dart';
import 'package:bookme/app/services/settings_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../login/model/login_model.dart';
import '../../login/repository/login_repository.dart';

enum SignUpLoading { parent, hide, otp}
class SignUpController extends GetxController with _SignUpInitializer{

  @override
  void onInit() {
    _loginRepository = LoginRepository();
    super.onInit();
  }

  Future<void> sendOtp(id) async {
    try{
      Map<String,dynamic> body = {
        "user_id" : id,
      };
      final response = await _loginRepository.sendOtp(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "Success"){
          Get.offAndToNamed(Routes.OTP,arguments: [id,'register']);
          // Get.back();
          successSnackBar(response['message']);
        } else if(response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }

    }catch(error) {
      Get.log("sendOtp Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    }
    return Future.value();
  }

  Future<void> signUp() async {
     try{
       isLoading.value = SignUpLoading.parent;
       Map<String,dynamic> body = {
         "fullname" : fullNameText.text.trim(),
         "username" : userNameText.text.trim(),
         "phone_no" : phoneText.trim(),
         "gender" : gender.value.toString()
       };
       final response = await _loginRepository.signUp(body,imageFile: imageFile.value.path.isNotEmpty ? imageFile.value : null );
       if(response != null){
         if(response['status'] != null && response['status'] == "OK"){
           imageFile.value = File("");
           await sendOtp(response['data']['ID']);
           // Get.back();
           // successSnackBar("${fullNameText.text} you are registered successfully.");
         } else if(response['status'] != null && response['message'] != null) {
           imageFile.value = File("");
           errorSnackBar("${response['message']}");
         }
       } else {
         Get.log(kSomeThingWentWrong,isError: true);
         errorSnackBar(kSomeThingWentWrong);
       }

     }catch(error) {
       Get.log("Login Error: $error",isError: true);
       errorSnackBar(kSomeThingWentWrong);
     } finally {
       isLoading.value = SignUpLoading.hide;
     }
     return Future.value();
  }

  void errorSnackBar(String message){
    if(!Get.isSnackbarOpen){
      Get.showSnackbar(Ui.ErrorSnackBar(message: message));
    }
  }
  void successSnackBar(String message){
    if(!Get.isSnackbarOpen){
      Get.showSnackbar(Ui.SuccessSnackBar(message: message));
    }
  }


}

mixin _SignUpInitializer {
  late LoginRepository _loginRepository;
  final isLoading = SignUpLoading.hide.obs;
  LoginModel? loginModel;
  bool isResend = false;
  final fullNameText = TextEditingController();
  final fullNameErrorFound = false.obs;
  final userNameText = TextEditingController();
  final userNameErrorFound = false.obs;
  String phoneText = "";
  final phoneTextErrorFound = false.obs;
  final isReadTermsAndCondition = false.obs;
  final pinEditingController = TextEditingController();
  final gender = kMale.obs;
  final imageFile = File("").obs;
}