import 'dart:convert';

import 'package:bookme/app/modules/reservation/repository/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../../providers/prefrences.dart';
import '../../login/model/login_model.dart';
import '../model/reservation_details_model.dart';
import '../model/reservation_model.dart';

enum ReservationsLoading { parent, hide, dialog, review }
class ReservationsController extends GetxController with _ReservationsInitializer{

  @override
  void onInit() {
    _reservationRepository = ReservationRepository();
    loadReservations();
    super.onInit();
  }

  @override
  Future<void> loadReservations() async {
    try{
      isLoading.value = ReservationsLoading.parent;
      final response = await _reservationRepository.reservations("&user_id=${LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!}");
      if(response != null){
        reservationModel = ReservationModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("loadReservations Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReservationsLoading.hide;
    }
    return Future.value();
  }

  @override
  Future<void> loadReservationDetails(String id) async {
    try{
      isLoading.value = ReservationsLoading.dialog;
      final response = await _reservationRepository.reservationDetails("&user_id=${LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!}&reservation_id=$id");
      if(response != null){
        reservationDetailsModel = ReservationDetailsModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("loadReservationDetails Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReservationsLoading.hide;
    }
    return Future.value();
  }

  @override
  Future<void> addReview(int index) async {
    try{
      isLoading.value = ReservationsLoading.review;
      Map<String,dynamic> body = {
        "restaurant_id" : reservationModel!.data!.elementAt(index).restaurantId,
        "reservation_id" : reservationModel!.data!.elementAt(index).id,
        "rating" : ratingStars.toString(),
        "review" : reviewText.text,
        "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
      };
      final response = await _reservationRepository.addReview(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          Get.back();
          successSnackBar("${response['message']}");
        } else if(response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        } else {
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("addReview Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReservationsLoading.hide;
    }
    return Future.value();
  }
  @override
  Future<void> cancelReservation(String id) async {
    try{
      isLoading.value = ReservationsLoading.dialog;
      Map<String,dynamic> body = {
        "reservation_id" : id,
        // "rating" : selectedReviewStar.toString(),
        // "review" : reviewText.text,
        // "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
      };
      final response = await _reservationRepository.cancelReservation(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          Get.back();
          loadReservations();
          successSnackBar("${response['message']}");
        } else if(response['status'] != null && response['message'] != null) {
          isLoading.value = ReservationsLoading.hide;
          errorSnackBar("${response['message']}");
        } else {
          isLoading.value = ReservationsLoading.hide;
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        isLoading.value = ReservationsLoading.hide;
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      isLoading.value = ReservationsLoading.hide;
      Get.log("cancelReservation Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    }
    return Future.value();
  }

  void errorSnackBar(String message){
    if(!Get.isSnackbarOpen){
      Get.showSnackbar(Ui.ErrorSnackBar(message: message));
    }
  }

  void successSnackBar(String message){
    if(!Get.isSnackbarOpen){
      Get.showSnackbar(Ui.SuccessSnackBar(message: message));
    }
  }

  void updateReview(){
    update([kUpdateReview]);
  }

}

mixin _ReservationsInitializer {
  late ReservationRepository _reservationRepository;
  final isLoading = ReservationsLoading.hide.obs;
  ReservationModel? reservationModel;
  ReservationDetailsModel? reservationDetailsModel;
  final ratingStars = 0.0.obs;
  final reviewText = TextEditingController();
  Future<void> loadReservations();
  Future<void> loadReservationDetails(String id);
  Future<void> addReview(int index);
  Future<void> cancelReservation(String id);
}

const kUpdateReview = "update_review";