class AppSettingModel {
  String? baseUrl;
  String? appName;
  String? defaultTheme;
  String? primaryColor;
  String? primaryDarkColor;
  String? accentColor;
  String? scaffoldBackgroundColor;
  String? appbarColor;
  String? textColor;
  String? fontFamily;
  String? googleMapsKey;
  String? mobileLanguage;
  String? appVersion;

  AppSettingModel(
      {this.baseUrl,
        this.appName,
        this.defaultTheme,
        this.primaryColor,
        this.primaryDarkColor,
        this.accentColor,
        this.scaffoldBackgroundColor,
        this.appbarColor,
        this.textColor,
        this.fontFamily,
        this.googleMapsKey,
        this.mobileLanguage,
        this.appVersion});

  AppSettingModel.fromJson(Map<String, dynamic> json) {
    baseUrl = json['base_url'];
    appName = json['app_name'];
    defaultTheme = json['default_theme'];
    primaryColor = json['primary_color'];
    primaryDarkColor = json['primary_dark_color'];
    accentColor = json['accent_color'];
    scaffoldBackgroundColor = json['scaffold_background_color'];
    appbarColor = json['appbar_color'];
    textColor = json['text_color'];
    fontFamily = json['font_family'];
    googleMapsKey = json['google_maps_key'];
    mobileLanguage = json['mobile_language'];
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['base_url'] = this.baseUrl;
    data['app_name'] = this.appName;
    data['default_theme'] = this.defaultTheme;
    data['primary_color'] = this.primaryColor;
    data['primary_dark_color'] = this.primaryDarkColor;
    data['accent_color'] = this.accentColor;
    data['scaffold_background_color'] = this.scaffoldBackgroundColor;
    data['appbar_color'] = this.appbarColor;
    data['text_color'] = this.textColor;
    data['font_family'] = this.fontFamily;
    data['google_maps_key'] = this.googleMapsKey;
    data['mobile_language'] = this.mobileLanguage;
    data['app_version'] = this.appVersion;
    return data;
  }
}