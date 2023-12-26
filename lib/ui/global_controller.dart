import 'dart:io';
import 'dart:io';

import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/location_data.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common/routes.dart';
import 'common/strings.dart';
import 'common/widgets/cancel_button.dart';

class GlobalController extends GetxController {
  //for global
  RxString lastUpdate = '-'.obs;

  @override
  void onInit() {
    super.onInit();
    lastUpdate.value = '1';
  }

  void btnLogoutTap(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text(StringConstants.appName),
          content: const Text(StringConstants.msgLogout),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text(StringConstants.no),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
              child: const Text(StringConstants.yes),
              onPressed: () {
                AppComponentBase.instance.sharedPreference.clearData();
                Get.offAllNamed(RouteName.loginPage);
              },
            ),
          ],
        ),
      );
    } else {
      Get.defaultDialog(
          title: StringConstants.appName,
          middleText: StringConstants.msgLogout,
          radius: 5,
          titleStyle: TextStyle(
              fontFamily: FontFamily.OpenSans,
              fontWeight: FontWeight.bold,
              color: AppTheme.of(context).primaryColor),
          confirm: BroncoButton(
            onPress: () {
              AppComponentBase.instance.sharedPreference.clearData();
              Get.offAllNamed(RouteName.loginPage);
            },
            width: 180.w,
            height: 80.h,
            color: AppTheme.of(context).primaryColor.withOpacity(0.7),
            hasGradientBg: false,
            text: StringConstants.yes,
            rounder: 3,
            blurRadius: 0.1,
          ),
          cancel: CancelButton(
            onPress: () => Get.back(),
            width: 180.w,
            height: 80.h,
            blurRadius: 0.1,
            rounderCorner: 3,
            text: StringConstants.no,
          ));
    }
  }

  Future<LocationData> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.value(
          LocationData(false, 'Location services are disabled.', null, 401));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.value(
            LocationData(false, 'Location permissions are denied.', null, 402));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.value(LocationData(
          false,
          'Location permissions are permanently denied, we cannot request permissions.',
          null,
          403));
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition();
    return Future.value(LocationData(true, '', position, 200));
  }
}
