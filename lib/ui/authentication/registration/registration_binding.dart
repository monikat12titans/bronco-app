import 'package:bronco_trucking/ui/authentication/registration/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
          () => RegistrationController(),
    );
  }
}
