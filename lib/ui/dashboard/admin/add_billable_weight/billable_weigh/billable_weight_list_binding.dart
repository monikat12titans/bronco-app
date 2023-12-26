import 'package:bronco_trucking/ui/dashboard/admin/add_billable_weight/billable_weigh/billable_weight_list_controller.dart';
import 'package:get/get.dart';

class BillableWeightListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillableWeightListController>(
      () => BillableWeightListController(),
    );
  }
}
