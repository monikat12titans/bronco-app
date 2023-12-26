import 'package:get/get.dart';

import 'forgot_pass_controller.dart';

class ForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );
  }
}
