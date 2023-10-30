import 'dart:convert';
import 'dart:io';
import 'package:bookme/app/providers/prefrences.dart';
import 'package:dio/dio.dart' as mDio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/setting_model.dart';
import '../services/settings_service.dart';

class ApiClient {
  mDio.Dio? _dio;
  late AppSettingModel appSetting;
  ApiClient() {
    _dio = mDio.Dio();
    appSetting = Get.find<SettingsService>().appSetting;
  }

  Future<dynamic> getRequest(params, endPoint) async {
    try {
      // if (Preferences.getAuth != null) {
      //   final auth = jsonDecode(Preferences.getAuth!);
      //   _dio?.options.headers["authorization"] = "${auth['token']}";
      //   Get.log("@getRequest $endPoint Token: ${auth['token']}");
      // }
      params = "auth_token=0cfc4e21af1504b2c48894b57cbc36b8" + params;
      final _path = appSetting.baseUrl! + "$endPoint?" + params;
      Get.log("@getRequest $endPoint path: $_path");
      final response = await _dio!.get(_path);
      if (response.statusCode == 200) {
        Get.log("@getRequest $endPoint Response: ${response.data}");
        return response.data;
      } else {
        Get.log("@getRequest $endPoint StatusCode: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Get.log("@getRequest $endPoint Error: ${e.toString()}", isError: true);
      return null;
    }
  }

  Future<dynamic> postRequest(Map<String, dynamic> body, endPoint) async {
    try {
      final _path = appSetting.baseUrl! + "$endPoint";
      debugPrint("you enter to post request.... : " + _path);
      body.addAll({"auth_token": "0cfc4e21af1504b2c48894b57cbc36b8"});
      Get.log("@postRequest $endPoint path: $_path");
      Get.log("@postRequest $endPoint body: ${json.encode(body)}");
      // if (Preferences.getAuth != null) {
      //   final auth = jsonDecode(Preferences.getAuth!);
      //   _dio?.options.headers["authorization"] = "${auth['token']}";
      // }
      final formData = mDio.FormData.fromMap(body);
      final response = await _dio!.post(_path, data: formData);
      if (response.statusCode == 200) {
        Get.log("@postRequest $endPoint Response: ${response.data}");
        return response.data;
      } else {
        Get.log("@postRequest $endPoint StatusCode: ${response.statusCode}");
        throw Exception(response.data);
      }
    } catch (e) {
      Get.log("@postRequest $endPoint Error: $e", isError: true);
      throw Exception(e);
    }
  }

  Future<dynamic> postRequestWithFormData(Map<String, dynamic> body, endPoint,
      {File? file}) async {
    try {
      final _path = appSetting.baseUrl! + "$endPoint";
      body.addAll({"auth_token": "0cfc4e21af1504b2c48894b57cbc36b8"});
      if (file != null) {
        body.addAll({
          "customer_image": await mDio.MultipartFile.fromFile(
            file.path,
            filename: file.path,
          )
        });
      }
      Get.log("@postRequestWithFormData $endPoint path: $_path");
      Get.log("@postRequestWithFormData $endPoint body: $body");
      final formData = mDio.FormData.fromMap(body);
      final response = await _dio!.post(_path, data: formData);
      if (response.statusCode == 200) {
        Get.log("@postRequest $endPoint Response: ${response.data}");
        return response.data;
      } else {
        Get.log("@postRequest $endPoint StatusCode: ${response.statusCode}");
      }
      return null;
    } catch (e) {
      Get.log("@postRequest $endPoint Error: $e", isError: true);
      return null;
    }
  }
}
