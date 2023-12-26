import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/dashboard/driver/check_in_list/check_in_list_controller.dart';
import 'package:bronco_trucking/ui/dashboard/driver/submit_to_office/submit_to_office_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SuccessErrorController extends GetxController
    with SingleGetTickerProviderMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this);

  late final Animation<double> animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutSine,
  );

  @override
  void onInit() {
    _controller.forward();
    super.onInit();
  }

  void onBackPress(
    bool isSuccess,
    UploadFrom uploadFrom,
  ) {
    switch (uploadFrom) {
      case UploadFrom.pickUpCheckIn:
        CheckInListController controller = Get.find();
        controller.getOrderList();
        break;
      case UploadFrom.pickUpSubmitToOffice:
        SubmitToOfficeController controller = Get.find();
        controller.getOrderList();
        break;
      case UploadFrom.delivery:
        CheckInListController controller = Get.find();
        controller.getOrderList(isPickup: false);
        break;
      case UploadFrom.pickUpSubmitToOfficeSubmit:
        // Get.back(result: isSuccess);
        break;
    }
    Get.back(result: isSuccess);
  }
}
