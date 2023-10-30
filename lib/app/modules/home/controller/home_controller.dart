import 'dart:convert';

import 'package:bookme/app/modules/login/model/login_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import '../../../../common/builder_ids.dart';
import '../../../providers/prefrences.dart';

class HomeController extends GetxController with _HomeInitializer{

   @override
  void onInit() {
      init();
    super.onInit();
  }

  void init(){
      if(Preferences.getAuth != null){
         loginModel = LoginModel.fromJson(jsonDecode(Preferences.getAuth!));
         updateProfileWidget();
      }
  }

  void onSelectPage(int index){
      selectedPage = index;
      update([kHomeBuilderId]);
   }

  void updateProfileWidget(){
      update([kUpdateProfileWidget]);
  }

}

mixin _HomeInitializer {
   final bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
   LoginModel? loginModel;
   int selectedPage = 0;
   final drawerController = AdvancedDrawerController();
}

String kUpdateProfileWidget = "update-profile-widget";