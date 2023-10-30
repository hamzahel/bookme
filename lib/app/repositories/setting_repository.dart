

import 'package:bookme/app/models/lang_model.dart';
import 'package:bookme/common/assets/asset_path.dart';

import '../../common/helper.dart';
import '../models/setting_model.dart';

class SettingRepository {


  Future<AppSettingModel> getSettings() async {
    final response = await Helper.getJsonFile(kAllJson);
    return AppSettingModel.fromJson(response);
  }

  Future<LangModel> getLanguage(String code) async {
    final response = await Helper.getJsonFile( code == 'en' ? kEnJson : kArJson);
    return LangModel.fromJson(response);
  }

}