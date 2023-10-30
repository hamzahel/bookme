

import 'package:bookme/app/providers/prefrences.dart';
import 'package:bookme/app/routes/app_routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class RootController extends GetxController {

  String selectedLang = "";
  late bool isLangPreferencesExist;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init(){
    isLangPreferencesExist = Preferences.getLang != null;
    Future.delayed(const Duration(seconds: 2),(){
      FlutterNativeSplash.remove();
      if(Preferences.getLang != null){
        preferences();
      }
    });
  }

  void preferences(){
    if(Preferences.getAuth != null){
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

}