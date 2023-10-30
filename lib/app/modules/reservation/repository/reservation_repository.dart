
import '../../../providers/api_client.dart';
import '../../../providers/end_points.dart';

class ReservationRepository extends ApiClient{

  Future<dynamic> reservations(params) async {
    return await getRequest("$params", kAllReservations);
  }

  Future<dynamic> reservationDetails(params) async {
    return await getRequest("$params", kReservationDetail);
  }

  Future<dynamic> addReview(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kProcessAddReview);
    } catch (e){
      throw Exception(e);
    }
  }
  Future<dynamic> cancelReservation(Map<String,dynamic> body) async {
    try{
      return await postRequest(body, kCancelReservation);
    } catch (e){
      throw Exception(e);
    }
  }


}