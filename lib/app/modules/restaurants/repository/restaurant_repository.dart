import '../../../providers/api_client.dart';
import '../../../providers/end_points.dart';

class RestaurantRepository extends ApiClient{

  Future<dynamic> locations() async {
    return await getRequest("", kAllLocations);
  }
  Future<dynamic> restaurant(params) async {
    return await getRequest("$params", kRestaurantsByLocations);
  }

  Future<dynamic> favourites(params) async {
    return await getRequest("$params", kFavourites);
  }
  Future<dynamic> restaurantDetails(params) async {
    return await getRequest("$params", kRestaurantsDetails);
  }

  Future<dynamic> menu(params) async {
    return await getRequest("$params", kGetMenu);
  }

  Future<dynamic> tableType(params) async {
    return await getRequest("$params", kGetTableType);
  }

  Future<dynamic> tablesByTableType(params) async {
    return await getRequest("$params", kGetTablesByTableType);
  }

  Future<dynamic> addReserve(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kReserveTable);
    } catch (e){
      throw Exception(e);
    }
  }
  Future<dynamic> addWaiting(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kAddToWaitingList);
    } catch (e){
      throw Exception(e);
    }
  }
  Future<dynamic> checkAvailability(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kProcessCheckAvailability);
    } catch (e){
      throw Exception(e);
    }
  }

  Future<dynamic> addDeleteFavourite(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kAddDeleteFavourite);
    } catch (e){
      throw Exception(e);
    }
  }

}