import 'package:bronco_trucking/ui/dashboard/driver/driver_dashboard_controller.dart';
import 'package:get/get.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverDashboardController>(
      () => DriverDashboardController(),
    );
  }
}
