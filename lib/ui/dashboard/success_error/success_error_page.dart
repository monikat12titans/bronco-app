import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/success_error_controller.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/widget/animated_icon_name.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessErrorMessage extends GetView<SuccessErrorController> {
  @override
  Widget build(BuildContext context) {
    Map data = Get.arguments as Map<String, dynamic>;
    bool isSuccess = data[Constant.argumentIsSuccess] as bool;
    String message = data[Constant.argumentMessage] as String;
    UploadFrom uploadFrom = UploadFrom.pickUpCheckIn;
    if (data.containsKey(Constant.argumentFrom)) {
      uploadFrom = UploadFrom.values[data[Constant.argumentFrom] as int];
    }
    return WillPopScope(
      onWillPop: () {
        controller.onBackPress(isSuccess, uploadFrom);
        return Future.value(true);
      },
      child: Scaffold(
        body: BroncoAppBar(
          onBackTap: () => controller.onBackPress(isSuccess, uploadFrom),
          child: AnimatedIconName(
              isSuccess: isSuccess,
              message: message,
              successErrorController: controller,
              uploadFrom: uploadFrom),
        ),
      ),
    );
  }
}
