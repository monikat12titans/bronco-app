import 'package:bronco_trucking/ui/dashboard/admin/admin_dashboard_controller.dart';
import 'package:get/get.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardController>(
      () => AdminDashboardController(),
    );
  }
}
