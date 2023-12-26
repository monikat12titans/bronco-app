import 'package:bronco_trucking/ui/dashboard/payment/payment_controller.dart';
import 'package:get/get.dart';

class CheckInListDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
          () => PaymentController(),
    );
  }
}
