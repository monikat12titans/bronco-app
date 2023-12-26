import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/admin_check_in_list_controller.dart';
import 'package:get/get.dart';

class AdminCheckInListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminCheckInListController>(
      () => AdminCheckInListController(),
    );
  }
}
