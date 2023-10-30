
import 'dart:io';

import 'package:bookme/app/localization/languages.dart';
import 'package:bookme/app/providers/prefrences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/services/settings_service.dart';


Future<void> initServices() async {
  Get.log('starting services ...');
  await Get.putAsync(() => SettingsService().init());
  Get.log('All services started...');
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  await initServices();

  runApp(
    GetMaterialApp(
      title: "Bookme",
      translations: Languages(),
      locale: Locale(
        Preferences.getLang != null ? Preferences.getLang!.split('-').first : 'ar',
        Preferences.getLang != null ? Preferences.getLang!.split('-').last : 'SAR'
      ),
      fallbackLocale: const Locale('ar', 'SAR'),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      themeMode: Get.find<SettingsService>().getThemeMode(),
      theme: Get.find<SettingsService>().getLightTheme(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

