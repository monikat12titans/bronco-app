import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_controller.dart';
import 'package:get/get.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDashboardController>(
      () => CustomerDashboardController(),
    );
  }
}
