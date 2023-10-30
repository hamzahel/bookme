
import 'package:bookme/app/modules/otp/controller/otp_controller.dart';
import 'package:get/get.dart';

class OtpBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
          () => OtpController(),
    );
  }

}