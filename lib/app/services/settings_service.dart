import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../common/app_color.dart';
import '../../common/ui.dart';
import '../models/setting_model.dart';
import '../repositories/setting_repository.dart';

class SettingsService extends GetxService {

  late AppSettingModel appSetting;

  SettingRepository? _settingsRepo;

  SettingsService() {

    _settingsRepo = SettingRepository();

  }

  Future<SettingsService> init() async {

    appSetting = await _settingsRepo!.getSettings();

    return this;
  }

  ThemeData getLightTheme() {
    // TODO change font dynamically
    return ThemeData(
        primaryColor: Ui.parseColor(appSetting.primaryColor!),
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            backgroundColor: Ui.parseColor(appSetting.appbarColor!),
            titleTextStyle: TextStyle(
                fontFamily: appSetting.fontFamily,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor, height: 1.2),
            iconTheme: IconThemeData(
                color: AppColors.whiteColor
            )
        ),


        accentColor: Ui.parseColor(appSetting.accentColor!),
        secondaryHeaderColor: Ui.parseColor(appSetting.accentColor!),
        dividerColor: Ui.parseColor(appSetting.accentColor!, opacity: 0.1),
        focusColor: Ui.parseColor(appSetting.accentColor!),
        hintColor: Ui.parseColor(appSetting.textColor!, opacity: 0.6),
        scaffoldBackgroundColor: Ui.parseColor(appSetting.scaffoldBackgroundColor!),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Ui.parseColor(appSetting.primaryColor!)),
        ),
        colorScheme: ColorScheme.light(
          primary: Ui.parseColor(appSetting.primaryColor!),
          secondary: Ui.parseColor(appSetting.primaryColor!),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.3),
          headline5: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.3),
          headline4: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.3),
          headline3: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.3),
          headline2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.4),
          headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.4),
          // subtitle2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Ui.parseColor(appSetting.textColor!), height: 1.2),
          // subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Ui.parseColor(appSetting.primaryColor!), height: 1.2),
          // bodyText2: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: Ui.parseColor(appSetting.textColor!), height: 1.2),
          // bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Ui.parseColor(appSetting.textColor!), height: 1.2),
          caption: TextStyle(fontSize: 8.0, fontWeight: FontWeight.normal, color: Ui.parseColor(appSetting.textColor!), fontFamily: appSetting.fontFamily, height: 1.2),
        ));
  }

  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        if (appSetting.defaultTheme == "dark") {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.dark.copyWith(systemNavigationBarColor: Colors.black87),
          );
          return ThemeMode.dark;
        } else {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.white),
          );
          return ThemeMode.light;
        }
    }
  }

}