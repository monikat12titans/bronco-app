import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/location_data.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDashboardController extends GetxController {
  late var globalController;
  late Rx<UserData> userData = UserData.empty().obs;

  @override
  void onReady() {
    super.onReady();
    globalController = Get.find<GlobalController>();
    getUserData();
    //checkPermission();
  }

  void btnLogoutTap() =>
      Get.find<GlobalController>().btnLogoutTap(Get.context!);

  void checkPermission() async {
    var locationData = await globalController.getCurrentPosition();
    if (locationData != null && locationData is LocationData) {
      if (locationData.status) {
        print(
            '-------location:${locationData.position!.latitude},${locationData.position!.longitude}');
      } else if (!locationData.status && locationData.errorCode == 402) {
        Get.defaultDialog(
            title: 'Location Error',
            barrierDismissible: false,
            middleText: 'Please enable location from setting',
            actions: [
              BroncoButton(
                onPress: () {
                  Get.back();
                },
                text: StringConstants.ok,
              )
            ]);
      }
    } else {
      Utils.displaySnack(message: StringConstants.errorLocationPermission);
    }
  }

  Future<void> getUserData() async {
    userData.value =
        await AppComponentBase.instance.sharedPreference.getUserData();
  }
}
