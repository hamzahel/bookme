
import 'package:bookme/app/modules/restaurants/controllers/tables_controller.dart';
import 'package:get/get.dart';

class TablesBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<TablesController>(
          () => TablesController(),
    );
  }

}