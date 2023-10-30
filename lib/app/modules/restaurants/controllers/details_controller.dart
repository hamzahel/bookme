import 'package:bookme/app/modules/restaurants/models/menu_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../models/restaurants_model.dart';
import '../repository/restaurant_repository.dart';

enum DetailsLoading { parent, hide }
class DetailsController extends GetxController with _DetailsInitializer{

  @override
  void onInit() {
    _restaurantRepository = RestaurantRepository();
    loadRestaurantsDetails();
    super.onInit();
  }

  @override
  Future<void> loadRestaurantsDetails() async {
    try{
      isLoading.value = DetailsLoading.parent;
      final response = await _restaurantRepository.restaurantDetails("&restaurant_id=${Get.arguments[1]}");
      if(response != null){
        restaurantsModel = RestaurantsModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      loadMenuModel();
    }
    return Future.value();
  }

  @override
  Future<void> loadMenuModel() async {
    try{
      final response = await _restaurantRepository.menu("&restaurant_id=${Get.arguments[1]}");
      if(response != null){
        menuModel = MenuModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = DetailsLoading.hide;
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

}

mixin _DetailsInitializer {
  late RestaurantRepository _restaurantRepository;
  late GoogleMapController googleMapController;
  final isLoading = DetailsLoading.hide.obs;
  RestaurantsModel? restaurantsModel;
  MenuModel? menuModel;
  Future<void> loadRestaurantsDetails();
  Future<void> loadMenuModel();
}