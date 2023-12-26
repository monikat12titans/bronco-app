import 'package:bronco_trucking/ui/dashboard/pod/pod_controller.dart';
import 'package:get/get.dart';

class PODBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PODController>(
      () => PODController(),
    );
  }
}
