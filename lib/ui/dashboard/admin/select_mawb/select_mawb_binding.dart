import 'package:bronco_trucking/ui/dashboard/admin/select_mawb/select_mawb_controller.dart';
import 'package:get/get.dart';

class SelectMAWBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectMAWBController>(
      () => SelectMAWBController(),
    );
  }
}
