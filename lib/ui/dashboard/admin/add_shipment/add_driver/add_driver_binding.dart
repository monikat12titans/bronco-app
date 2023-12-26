import 'package:get/get.dart';

import 'add_driver_controller.dart';

class AddDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDriverController>(
      () => AddDriverController(),
    );
  }
}
