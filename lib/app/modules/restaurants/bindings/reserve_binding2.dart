
import 'package:bookme/app/modules/restaurants/controllers/reserve_controller2.dart';
import 'package:get/get.dart';

class ReserveBinding2 extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ReserveController2>(
          () => ReserveController2(),
    );
  }

}