import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/customer_data.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/customer_list_response.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';

import '../../admin_dashboard_controller.dart';

class SelectCustomerController extends GetxController with APIState {
  List<CustomerData> customerDataList = <CustomerData>[];
  List<CustomerData> searchCustomerDataList = <CustomerData>[];
  String previousSelectedId = '-1';

  TextEditingController searchTextEditController = TextEditingController();

  List<String> mbnNumber = [];
  bool isFromMessage = false;
  int selectedId = -1;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments is List<String>) {
      mbnNumber = Get.arguments as List<String>;
    }
    if (Get.arguments is Map) {
      isFromMessage = (Get.arguments as Map)[0] as bool;
      selectedId = (Get.arguments as Map)[1] as int;
    }
    getCustomerListAPI();
  }

  void onRadioTap(CustomerData customerData, Object value) {
    if (customerData.isSelected.isTrue) return;

    if (customerData.id.compareTo(previousSelectedId) != 0) {
      if (previousSelectedId.compareTo('-1') != 0) {
        var previousSelectedIndex = customerDataList
            .indexWhere((element) => element.id == previousSelectedId);
        customerDataList[previousSelectedIndex].isSelected.value = false;

        // var searchListId = searchCustomerDataList.map((e) => e.id);

        /* var tempSearchList = customerDataList
            .where((element) => searchListId.contains(element.id));
      //  searchCustomerDataList.clear();
      //  searchCustomerDataList.addAll(tempSearchList);*/
      }
      customerData.isSelected.value = true;
      previousSelectedId = customerData.id;
    }
  }

  Future<void> btnSubmitTap() async {
    bool isAnyItemSelected =
        searchCustomerDataList.any((element) => element.isSelected.isTrue);
    if (isAnyItemSelected) {
      AppComponentBase.instance.showProgressDialog();
      final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
          .assignCustomer(mbnNumber, int.parse(previousSelectedId));

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
      Utils.displaySnack(message: StringConstants.errorSelectCustomer);
    }
  }

  Future<void> btnDoneTap() async {
    bool isAnyItemSelected =
        searchCustomerDataList.any((element) => element.isSelected.isTrue);
    if (isAnyItemSelected) {
      CustomerData selectedCustomer = searchCustomerDataList
          .where((element) => element.isSelected.isTrue)
          .toList()
          .first;
      Get.back(result: selectedCustomer);
    } else {
      Utils.displaySnack(message: StringConstants.errorSelectCustomer);
    }
  }

  Future<void> getCustomerListAPI() async {
    setAPIState(Status.loading);
    customerDataList.clear();
    searchCustomerDataList.clear();
    previousSelectedId = '-1';

    if (isFromMessage && selectedId != -1) {
      previousSelectedId = '$selectedId';
    }
    AppComponentBase.instance.showProgressDialog();
    final CustomerListResponse customerListResponse =
        await AppComponentBase.instance.apiProvider.getCustomerList();

    if (customerListResponse.isOKay && customerListResponse.data != null) {
      setAPIState(customerListResponse.data!.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      for (final user in customerListResponse.data!) {
        var customerData = CustomerData(user.userid ?? '', user.fullName,
            user.fullAddress, user.phone ?? '-', user.email ?? '-');

        if (isFromMessage &&
            selectedId != -1 &&
            int.parse(user.userid ?? '-1') == selectedId) {
          customerData.isSelected.value = true;
        }
        customerDataList.add(customerData);
      }

      searchCustomerDataList.addAll(customerDataList);
    } else {
      setAPIState(Status.error);
      Utils.displaySnack(message: customerListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  Future<void> onSearchTextChanged(String text) async {
    setAPIState(Status.loading);
    searchCustomerDataList.clear();
    if (text.isEmpty) {
      searchCustomerDataList.addAll(customerDataList);
      setAPIState(searchCustomerDataList.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      return;
    }

    for (final user in customerDataList) {
      if (user.name.toLowerCase().contains(text.toLowerCase())) {
        searchCustomerDataList.add(user);
      }
    }
    setAPIState(searchCustomerDataList.isEmpty
        ? Status.successWithEmptyList
        : Status.success);
  }
}
