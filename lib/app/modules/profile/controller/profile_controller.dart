import 'dart:convert';

import 'package:bookme/common/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../../providers/prefrences.dart';
import '../../home/controller/home_controller.dart';
import '../../login/model/login_model.dart';
import '../../login/repository/login_repository.dart';

enum ProfileLoading { parent, hide }
class ProfileController extends GetxController with _ProfileInitializer{

  @override
  void onInit() {
    _loginRepository = LoginRepository();
    init();
    super.onInit();
  }

  void init(){
    if(Preferences.getAuth != null){
      loginModel = LoginModel.fromJson(jsonDecode(Preferences.getAuth!));
      fullNameText.text = loginModel?.data?.fullName ?? "";
      userNameText.text = loginModel?.data?.username ?? "";
      emailText.text = loginModel?.data?.email ?? "";
      phoneText = loginModel?.data?.phone ?? "";
      final countries = Countries.allCountries;
      for(int i = 0; i < countries.length; i++){
        if(phoneText.trim().contains(countries.elementAt(i)['dial_code']!)){
          initialCountryCode = countries.elementAt(i)['code']!;
          initialDialCode = countries.elementAt(i)['dial_code']!;
          break;
        }
      }
      updateParent();
    }
  }

  @override
  Future<void> updateProfile() async {
    try{
      isLoading.value = ProfileLoading.parent;
      Map<String,dynamic> body = {
        "user_id" : loginModel!.data!.id,
        "fullname" : fullNameText.text.trim(),
        "username" : userNameText.text.trim(),
        "email" : emailText.text.trim(),
        "phone" : phoneText.trim(),
      };
      final response = await _loginRepository.updateProfile(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          loginModel!.data!.fullName = fullNameText.text;
          loginModel!.data!.username = userNameText.text;
          loginModel!.data!.email = emailText.text;
          loginModel!.data!.phone = phoneText;
          final json = jsonEncode(loginModel!.toJson());
          await Preferences.setAuth(json);
          init();
          Get.find<HomeController>().init();
          successSnackBar("${response['message']}");
        } else if(response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        } else {
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }

    }catch(error) {
      Get.log("Update Profile Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ProfileLoading.hide;
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
  void updateParent(){
    update(["parent_id",'parent_id_2']);
  }

}
mixin _ProfileInitializer{

  late LoginRepository _loginRepository;
  final isLoading = ProfileLoading.hide.obs;

  LoginModel? loginModel;

  final fullNameText = TextEditingController();
  final fullNameErrorFound = false.obs;
  final userNameText = TextEditingController();
  final userNameErrorFound = false.obs;
  final emailText = TextEditingController();
  final emailErrorFound = false.obs;
  String phoneText = "";
  final phoneTextErrorFound = false.obs;
  String initialCountryCode = "AF";
  String initialDialCode = "+93";
  bool isEditAble = false;
  late String selectedLanguage;

  Future<void> updateProfile();

}