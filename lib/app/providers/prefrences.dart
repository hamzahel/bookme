import 'package:get_storage/get_storage.dart';

const String _kAuthKey = "auth";
const String _kLang = "lang";

class Preferences {
  static String? get getAuth => GetStorage().read<String>(_kAuthKey);

  static Future<void> setAuth(String value) async => await GetStorage().write(_kAuthKey, value);

  static Future<void> deleteAuth() async => await GetStorage().remove(_kAuthKey);

  static String? get getLang => GetStorage().read<String>(_kLang);

  static Future<void> setLang(String value) async => await GetStorage().write(_kLang, value);

  static Future<void> deleteLang() async => await GetStorage().remove(_kLang);

}
