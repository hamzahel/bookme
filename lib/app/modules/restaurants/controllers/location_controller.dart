import 'package:bookme/app/modules/restaurants/models/loactions_model.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../repository/restaurant_repository.dart';

enum LocationLoading { parent, hide }
class LocationController extends GetxController with _LocationInitializer {

  @override
  void onInit() {
    _restaurantRepository = RestaurantRepository();
    loadLocations();
    super.onInit();
  }

  @override
  Future<void> loadLocations() async {
    try{
      isLoading.value = LocationLoading.parent;
      final response = await _restaurantRepository.locations();
      if(response != null){
        locationModel = LocationModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = LocationLoading.hide;
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

mixin _LocationInitializer {
  late RestaurantRepository _restaurantRepository;
  final isLoading = LocationLoading.hide.obs;
  LocationModel? locationModel;
  Future<void> loadLocations();
}