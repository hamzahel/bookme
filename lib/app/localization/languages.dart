import 'package:bookme/app/localization/ar.dart';
import 'package:bookme/app/localization/en.dart';
import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_SAR': arLangMap,
    'en_US': englishLangMap,
  };
}