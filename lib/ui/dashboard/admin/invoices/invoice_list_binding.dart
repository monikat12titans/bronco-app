import 'package:get/get.dart';

import 'invoice_list_controller.dart';

class InvoiceListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceListController>(
          () => InvoiceListController(),
    );
  }
}
