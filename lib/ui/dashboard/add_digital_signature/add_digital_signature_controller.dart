import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

class AddDigitalSignatureController extends GetxController {
  late HandSignatureControl handSignatureControl;

  @override
  void onInit() {
    handSignatureControl = HandSignatureControl(
      threshold: 5.0,
    );
    super.onInit();
  }

  Future<void> btnDoneTap() async {
    try {
      ByteData? byteData = await handSignatureControl.toImage();
      handSignatureControl.clear();
      Get.back(result: byteData);
    } on Exception catch (_) {
      Utils.displaySnack(message: 'Please add signature');
    }
  }
}
