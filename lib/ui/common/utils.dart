import 'dart:io';
import 'dart:typed_data';

import 'package:bronco_trucking/di/api/api_client.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static const animationDuration = Duration(milliseconds: 200);

  static String getDateFromTimestamp(int timestamp) =>
      DateFormat('dd-MM-yyyy hh:mm a')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));

  static void displaySnack(
      {String message = StringConstants.errorSomethingWentWrong,
      bool isSuccess = false}) {
    if (kIsWeb) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        width: Get.width * 0.3,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ));
    } else {
      Get.snackbar(
        isSuccess ? StringConstants.success : StringConstants.error,
        message,
        duration: const Duration(seconds: 2),
        backgroundColor: isSuccess ? Colors.green : Colors.red.withOpacity(0.8),
        snackPosition: SnackPosition.BOTTOM,
        borderWidth: Platform.isAndroid ? 0 : 1,
        colorText: Colors.white,
        barBlur: 0,
      );
    }
  }

  static String productImagePath(String productImageName) =>
      '${ApiClient.baseServerPath}assets/images/$productImageName';

  static String productSignaturePath(String signature) =>
      '${ApiClient.baseServerPath}assets/signature/$signature';

  static bool isSelfMessage(String userLoginId, String customerId) {
    return userLoginId == customerId;
  }

}
