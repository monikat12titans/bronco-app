import 'package:bronco_trucking/ui/dashboard/payment/payment_controller.dart';
import 'package:get/get.dart';

import 'order_status_controller.dart';

class OrderStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderStatusController>(
      () => OrderStatusController(),
    );
  }
}
