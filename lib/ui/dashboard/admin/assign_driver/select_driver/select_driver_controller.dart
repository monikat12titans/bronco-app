import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/driver_data.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/driver_list_response.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../admin_dashboard_controller.dart';

class SelectDriverController extends GetxController with APIState {
  List<DriverData> driverList = [];
  List<DriverData> searchDriverList = [];
  String previousSelectedId = '-1';
  TextEditingController searchTextEditController = TextEditingController();

  @override
  void onInit() {
    getDriverListAPI();
    super.onInit();
  }

  void onRadioTap(DriverData driverData) {
    if (driverData.isSelected.isTrue) return;

    if (driverData.id.compareTo(previousSelectedId) != 0) {
      if (previousSelectedId.compareTo('-1') != 0) {
        var previousSelectedIndex = driverList
            .indexWhere((element) => element.id == previousSelectedId);
        driverList[previousSelectedIndex].isSelected.value = false;
      }
      driverData.isSelected.value = true;
      previousSelectedId = driverData.id;
    }
  }

  Future<void> btnSubmitTap(List<String> mbnId) async {
    bool isAnyItemSelected =
        driverList.any((element) => element.isSelected.isTrue);
    if (isAnyItemSelected) {
      AppComponentBase.instance.showProgressDialog();
      final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
          .assignDriver(mbnId, int.parse(previousSelectedId));

      Utils.displaySnack(
          message: apiStatus.errorMessage, isSuccess: apiStatus.isOKay);
      AppComponentBase.instance.hideProgressDialog();

      // Navigate to home screen
      if (apiStatus.isOKay) {
        await Future.delayed(const Duration(seconds: 2));

        final AdminDashboardController controller =
            Get.find<AdminDashboardController>();
        await controller.getOrderList();
        Get.offNamedUntil(RouteName.adminDashboardPage,
            (route) => route.settings.name == RouteName.adminDashboardPage);
      }
    } else {
      Utils.displaySnack(message: StringConstants.errorSelectDriver);
    }
  }

  Future<void> getDriverListAPI() async {
    setAPIState(Status.loading);
    driverList.clear();
    searchDriverList.clear();
    previousSelectedId = '-1';
    AppComponentBase.instance.showProgressDialog();
    final DriverListResponse driverListResponse =
        await AppComponentBase.instance.apiProvider.getDriverList();

    if (driverListResponse.isOKay && driverListResponse.data != null) {
      setAPIState(driverListResponse.data!.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      for (final driver in driverListResponse.data!) {
        driverList.add(DriverData(driver.userid ?? '', driver.fullName));
      }
      searchDriverList.addAll(driverList);
    } else {
      setAPIState(Status.error);
      Utils.displaySnack(message: driverListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  Future<void> onSearchTextChanged(String text) async {
    setAPIState(Status.loading);
    searchDriverList.clear();
    if (text.isEmpty) {
      searchDriverList.addAll(driverList);
      setAPIState(searchDriverList.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      return;
    }

    for (final driver in driverList) {
      if (driver.name.toLowerCase().contains(text.toLowerCase())) {
        searchDriverList.add(driver);
      }
    }
    setAPIState(searchDriverList.isEmpty
        ? Status.successWithEmptyList
        : Status.success);
  }
}
