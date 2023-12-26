import 'package:get/get.dart';

import 'add_digital_signature_controller.dart';

class AddDigitalSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDigitalSignatureController>(
      () => AddDigitalSignatureController(),
    );
  }
}
