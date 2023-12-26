import 'package:bronco_trucking/ui/dashboard/admin/messages/admin_message_controller.dart';
import 'package:get/get.dart';

class AdminMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminMessageController>(
      () => AdminMessageController(),
    );
  }
}
