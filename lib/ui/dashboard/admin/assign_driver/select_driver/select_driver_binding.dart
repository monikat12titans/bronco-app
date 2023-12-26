import 'package:bronco_trucking/ui/dashboard/admin/assign_driver/select_driver/select_driver_controller.dart';
import 'package:get/get.dart';

class SelectDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectDriverController>(
      () => SelectDriverController(),
    );
  }
}
