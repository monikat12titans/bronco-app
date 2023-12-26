import 'package:bronco_trucking/ui/dashboard/driver/submit_to_office/submit_to_office_controller.dart';
import 'package:get/get.dart';

class SubmitToOfficeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitToOfficeController>(
          () => SubmitToOfficeController(),
    );
  }
}
