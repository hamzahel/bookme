

import 'dart:io';

import '../../../providers/api_client.dart';
import '../../../providers/end_points.dart';

class LoginRepository extends ApiClient{

  Future<dynamic> login(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kLogin);
    } catch (e){
      throw Exception(e);
    }
  }
  Future<dynamic> sendOtp(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kResendOtp);
    } catch (e){
      throw Exception(e);
    }
  }
  Future<dynamic> submitOtp(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kSubmitOtp);
    } catch (e){
      throw Exception(e);
    }
  }
  Future<dynamic> signUp(Map<String,dynamic> body, {File? imageFile}) async {
    try{
      if(imageFile != null){
        return await postRequestWithFormData(body, kRegister,file: imageFile);
      } else {
        return await postRequest(body, kRegister);
      }
    } catch (e){
      throw Exception(e);
    }
  }

  Future<dynamic> updateProfile(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kUpdateProfile);
    } catch (e){
      throw Exception(e);
    }
  }

}