import 'package:bronco_trucking/ui/dashboard/success_error/success_error_controller.dart';
import 'package:get/get.dart';

class SuccessErrorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessErrorController>(
      () => SuccessErrorController(),
    );
  }
}
