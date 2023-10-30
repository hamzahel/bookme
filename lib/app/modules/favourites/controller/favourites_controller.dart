import 'dart:convert';

import 'package:bookme/app/modules/favourites/models/favourite_model.dart';
import 'package:get/get.dart';

import '../../../../common/builder_ids.dart';
import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../../providers/prefrences.dart';
import '../../login/model/login_model.dart';
import '../../restaurants/repository/restaurant_repository.dart';

enum FavouritesLoading { parent, hide }
class FavouritesController extends GetxController with _FavouritesInitializer{
  @override
  void onInit() {
    _restaurantRepository = RestaurantRepository();
    loadFavourites();
    super.onInit();
  }
  @override
  Future<void> loadFavourites() async {
    try{
      isLoading.value = FavouritesLoading.parent;
      final response = await _restaurantRepository.favourites("&user_id=${LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!}");
      if(response != null){
        favouriteModel = FavouriteModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("Login Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = FavouritesLoading.hide;
    }
    return Future.value();
  }

  @override
  Future<void> addDeleteFavourites(String id) async {
    try{
      isLoading.value = FavouritesLoading.parent;
      Map<String,dynamic> body = {
        "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
        "restaurant_id" : id,
      };
      final response = await _restaurantRepository.addDeleteFavourite(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          successSnackBar("${response['message']}");
          loadFavourites();
        } else if(response['status'] != null && response['message'] != null) {
          isLoading.value = FavouritesLoading.hide;
          errorSnackBar("${response['message']}");
        } else {
          isLoading.value = FavouritesLoading.hide;
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        isLoading.value = FavouritesLoading.hide;
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      isLoading.value = FavouritesLoading.hide;
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
mixin _FavouritesInitializer {
  late RestaurantRepository _restaurantRepository;
  final isLoading = FavouritesLoading.hide.obs;
  FavouriteModel? favouriteModel;
  Map<String,dynamic> cardExpand = {"index" : -1 , "isExpanded" : false};
  Future<void> loadFavourites();
  Future<void> addDeleteFavourites(String id);

}