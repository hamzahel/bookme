import 'dart:convert';

import 'package:bookme/app/modules/login/controller/login_controller.dart';
import 'package:bookme/app/modules/login/repository/login_repository.dart';
import 'package:bookme/app/providers/prefrences.dart';
import 'package:bookme/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';

enum OtpLoading { parent, hide }
class OtpController extends GetxController with _LoginInitializer{

  @override
  void onInit() {
    _loginRepository = LoginRepository();
    super.onInit();
  }

  Future<void> submitOtp() async {
    try{
      isLoading.value = OtpLoading.parent;
      Map<String,dynamic> body = {
        "otp" : pinEditingController.text,
        "user_id" : Get.arguments[0],
      };
      final response = await _loginRepository.submitOtp(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "Success"){
          if(Get.arguments[1] == "login"){
            final loginModel = Get.find<LoginController>().loginModel;
            await Preferences.setAuth(jsonEncode(loginModel!.toJson()));
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.back();
            Get.back();
          }
          successSnackBar(response['message']);
        } else if(response['status'] != null && response['message'] != null) {
          pinEditingController.clear();
          errorSnackBar("${response['message']}");
        }
      } else {
        pinEditingController.clear();
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }

    }catch(error) {
      pinEditingController.clear();
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = OtpLoading.hide;
    }
    return Future.value();
  }

  Future<void> sendOtp() async {
    try{
      isLoading.value = OtpLoading.parent;
      Map<String,dynamic> body = {
        "user_id" : Get.arguments[0],
      };
      final response = await _loginRepository.sendOtp(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "Success"){
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
    } finally {
      isLoading.value = OtpLoading.hide;
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

mixin _LoginInitializer {
  late LoginRepository _loginRepository;
  final isLoading = OtpLoading.hide.obs;
  final formKey = GlobalKey<FormState>();
  final pinEditingController = TextEditingController();
}