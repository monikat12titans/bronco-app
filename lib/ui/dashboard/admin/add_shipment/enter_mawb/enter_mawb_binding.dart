import 'package:get/get.dart';

import 'enter_mawb_controller.dart';

class EnterMAWBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterMAWBController>(
          () => EnterMAWBController(),
    );
  }
}
