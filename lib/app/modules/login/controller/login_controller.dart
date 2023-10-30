import 'dart:convert';
import 'package:bookme/app/modules/login/model/login_model.dart';
import 'package:bookme/app/modules/login/repository/login_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../../providers/prefrences.dart';
import '../../../routes/app_routes.dart';

enum LoginLoading { parent, hide }

class LoginController extends GetxController with _LoginInitializer {
  @override
  void onInit() {
    _loginRepository = LoginRepository();
    super.onInit();
  }

  Future<void> sendOtp(id) async {
    try {
      Map<String, dynamic> body = {
        "user_id": id,
      };
      final response = await _loginRepository.sendOtp(body);
      if (response != null) {
        if (response['status'] != null && response['status'] == "Success") {
          Get.toNamed(Routes.OTP, arguments: [id, 'login']);
          // successSnackBar(response['message']);
        } else if (response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        }
      } else {
        Get.log(kSomeThingWentWrong, isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    } catch (error) {
      Get.log("sendOtp Error: $error", isError: true);
      errorSnackBar(kSomeThingWentWrong);
    }
    return Future.value();
  }

  @override
  Future<void> login() async {
    // Get.offAllNamed(Routes.HOME);
    try {
      isLoading.value = LoginLoading.parent;
      Map<String, dynamic> body = {"phone_no": phoneText};
      final response = await _loginRepository.login(body);
      if (response != null) {
        loginModel = LoginModel.fromJson(response);
        if (loginModel!.data != null) {
          if (loginModel!.data!.otpVerified == "Y") {
            await Preferences.setAuth(jsonEncode(loginModel!.toJson()));
            Get.offAllNamed(Routes.HOME);
          } else {
            // Get.toNamed(Routes.OTP,arguments: [loginModel!.data!.id,'login']);
            await sendOtp(loginModel!.data!.id);
          }
        } else {
          errorSnackBar(loginModel?.message ?? kSomeThingWentWrong);
        }
      } else {
        Get.log("Login Error", isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    } catch (error) {
      Get.log("Login Error: $error", isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = LoginLoading.hide;
    }
    return Future.value();
  }

  void errorSnackBar(String message) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: message));
    }
  }

  void successSnackBar(String message) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: message));
    }
  }
}

mixin _LoginInitializer {
  late LoginRepository _loginRepository;
  final isLoading = LoginLoading.hide.obs;
  LoginModel? loginModel;
  final formKey = GlobalKey<FormState>();
  String phoneText = "";
  final phoneTextErrorFound = false.obs;
  Future<void> login();
}
