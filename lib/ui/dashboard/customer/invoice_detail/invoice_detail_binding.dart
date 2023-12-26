import 'package:bronco_trucking/ui/dashboard/customer/invoice_detail/invoice_detail_controller.dart';
import 'package:get/get.dart';

class InvoiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceDetailController>(
      () => InvoiceDetailController(),
    );
  }
}
