import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/select_customer/select_customer_controller.dart';
import 'package:get/get.dart';

class SelectCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectCustomerController>(
      () => SelectCustomerController(),
    );
  }
}
