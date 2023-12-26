import 'package:bronco_trucking/ui/dashboard/customer/invoice_detail/invoice_detail_controller.dart';
import 'package:get/get.dart';

import 'invoice_payment_detail_controller.dart';

class InvoicePaymentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoicePaymentDetailController>(
      () => InvoicePaymentDetailController(),
    );
  }
}
