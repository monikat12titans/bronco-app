import 'package:get/get.dart';
import 'check_in_list_controller.dart';

class CheckInListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckInListController>(
      () => CheckInListController(),
    );
  }
}
