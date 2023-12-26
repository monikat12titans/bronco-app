import 'package:bronco_trucking/ui/dashboard/upload_pod/upload_pod_and_signature_controller.dart';
import 'package:get/get.dart';

class UploadPODAndSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadPODAndSignatureController>(
      () => UploadPODAndSignatureController(),
    );
  }
}
