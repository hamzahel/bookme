import 'dart:convert';

import 'package:bookme/app/modules/restaurants/models/restaurants_model.dart';
import 'package:bookme/common/builder_ids.dart';
import 'package:get/get.dart';
import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../../providers/prefrences.dart';
import '../../favourites/models/favourite_model.dart';
import '../../login/model/login_model.dart';
import '../repository/restaurant_repository.dart';

enum RestaurantsLoading { parent, hide }
class RestaurantsController extends GetxController with _RestaurantsInitializer {

  @override
  void onInit() {
    _restaurantRepository = RestaurantRepository();
    loadRestaurants();
    super.onInit();
  }

  @override
  Future<void> loadRestaurants() async {
    try{
      isLoading.value = RestaurantsLoading.parent;
      final response = await _restaurantRepository.restaurant("&location=${Get.arguments[0]}&user_id=${LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!}");
      if(response != null){
        restaurantsModel = RestaurantsModel.fromJson(response);
        await loadFavourites();
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = RestaurantsLoading.hide;
    }
    return Future.value();
  }

  @override
  Future<void> loadFavourites() async {
    try{
      favouriteList.clear();
      final response = await _restaurantRepository.favourites("&user_id=${LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!}");
      if(response != null){
       final favouriteModel = FavouriteModel.fromJson(response);
       if(favouriteModel.data != null){
         for (var element in favouriteModel.data!) {
           if(element.restaurantDetail?.id != null){
             favouriteList.add(element.restaurantDetail!.id!);
           }
         }
       }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    }
    return Future.value();
  }

  @override
  Future<void> addDeleteFavourites(String id) async {
    try{
      isLoading.value = RestaurantsLoading.parent;
      Map<String,dynamic> body = {
        "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
        "restaurant_id" : id,
      };
      final response = await _restaurantRepository.addDeleteFavourite(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          successSnackBar("${response['message']}");

          loadRestaurants();
        } else if(response['status'] != null && response['message'] != null) {
          isLoading.value = RestaurantsLoading.hide;
          errorSnackBar("${response['message']}");
        } else {
          isLoading.value = RestaurantsLoading.hide;
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        isLoading.value = RestaurantsLoading.hide;
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      isLoading.value = RestaurantsLoading.hide;
      Get.log("loadTablesByTableType Error: $error",isError: true);
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

  void updateCardExpand(){
    update([kCardExpandBuilderId]);
  }

}

mixin _RestaurantsInitializer {
  late RestaurantRepository _restaurantRepository;
  final isLoading = RestaurantsLoading.hide.obs;
  RestaurantsModel? restaurantsModel;
  List<String> favouriteList = [];
  Future<void> loadRestaurants();
  Future<void> loadFavourites();
  Future<void> addDeleteFavourites(String id);
}