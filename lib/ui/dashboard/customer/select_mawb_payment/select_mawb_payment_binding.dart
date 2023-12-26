import 'package:bronco_trucking/ui/dashboard/customer/select_mawb_payment/select_mawb_payment_controller.dart';
import 'package:get/get.dart';

class SelectMAWBPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectMAWBPaymentController>(
      () => SelectMAWBPaymentController(),
    );
  }
}
