import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/billable_weight_data.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class BillableWeightListController extends GetxController with APIState {
  List<BillableWeightData> billableWeightList = <BillableWeightData>[];
  List<BillableWeightData> searchBillableWeightList = <BillableWeightData>[];
  RxBool isExpandedPOD = false.obs;
  RxBool isExpandedOutStandingInvoices = false.obs;

  TextEditingController weightTextEditController = TextEditingController();
  TextEditingController lengthTextEditController = TextEditingController();
  TextEditingController heightTextEditController = TextEditingController();
  TextEditingController searchTextEditController = TextEditingController();
  TextEditingController amountTextEditController = TextEditingController();
  TextEditingController taxTextEditController = TextEditingController();

  @override
  void onInit() {
    getDeliveryOrderList();
    super.onInit();
  }

  Future<void> toExpandInvoiceItem(BillableWeightData billableWeightData,
      {bool hasExpand = false}) async {
    billableWeightData.isExpanded.value = hasExpand;
  }

  void setBillWeight(
      double weight, double length, double height, double amount, double tax) {
    weightTextEditController.text = weight == 0.0 ? '' : weight.toString();
    lengthTextEditController.text = length == 0.0 ? '' : length.toString();
    heightTextEditController.text = height == 0.0 ? '' : height.toString();
    amountTextEditController.text = amount == 0.0 ? '' : amount.toString();
    taxTextEditController.text = tax == 0.0 ? '' : tax.toString();
  }

  void btnOnDoneTap(int index) async {
    if (weightTextEditController.text.isNotEmpty &&
        lengthTextEditController.text.isNotEmpty &&
        heightTextEditController.text.isNotEmpty &&
        amountTextEditController.text.isNotEmpty &&
        taxTextEditController.text.isNotEmpty) {
      BillableWeightData billableData = billableWeightList[index];
      AppComponentBase.instance.showProgressDialog();
      final APIStatus addWeightAPIStatus =
          await AppComponentBase.instance.apiProvider.addBillable(
              '${billableData.mbnId}',
              weightTextEditController.text,
              lengthTextEditController.text,
              heightTextEditController.text,
              amountTextEditController.text,
              taxTextEditController.text);

      AppComponentBase.instance.hideProgressDialog();

      if (addWeightAPIStatus.isOKay) {
        billableWeightList[index]
          ..weight.value = double.parse(weightTextEditController.text)
          ..height.value = double.parse(heightTextEditController.text)
          ..length.value = double.parse(lengthTextEditController.text)
          ..amount.value = double.parse(amountTextEditController.text)
          ..tax.value = double.parse(taxTextEditController.text);
        cleanTextField();
        Get.back();
      } else {
        Utils.displaySnack(message: addWeightAPIStatus.errorMessage);
      }
    } else {
      Utils.displaySnack(message: StringConstants.errorFieldNotEmpty);
    }
  }

  Future<void> getDeliveryOrderList() async {
    setAPIState(Status.loading);
    billableWeightList.clear();
    searchBillableWeightList.clear();
    AppComponentBase.instance.showProgressDialog();
    final OrderListResponse orderListResponse =
        await AppComponentBase.instance.apiProvider.getDeliveryCheckList();

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      for (final order in orderListResponse.data!) {
        double weight = double.parse(
                order.weight == null || order.weight!.isEmpty
                    ? '0.0'
                    : order.weight ?? '0.0') +
            0.0;
        double height = double.parse(
                order.height == null || order.height!.isEmpty
                    ? '0.0'
                    : order.height ?? '0.0') +
            0.0;
        double length = double.parse(
                order.length == null || order.length!.isEmpty
                    ? '0.0'
                    : order.length ?? '0.0') +
            0.0;

        double invoiceAmount = double.parse(
                order.invoiceAmount == null || order.invoiceAmount!.isEmpty
                    ? '0.0'
                    : order.invoiceAmount ?? '0.0') +
            0.0;
        double taxAmount = double.parse(
                order.taxAmount == null || order.taxAmount!.isEmpty
                    ? '0.0'
                    : order.taxAmount ?? '0.0') +
            0.0;

        billableWeightList.add(BillableWeightData(
            int.parse(order.id ?? ''),
            int.parse(order.mbn ?? ''),
            weight.obs,
            length.obs,
            height.obs,
            invoiceAmount.obs,
            taxAmount.obs));
      }
      searchBillableWeightList.addAll(billableWeightList);
      setAPIState(searchBillableWeightList.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
    } else {
      setAPIState(Status.error, orderListResponse.errorMessage);
      // Utils.displaySnack(message: orderListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  void cleanTextField() {
    weightTextEditController.clear();
    lengthTextEditController.clear();
    heightTextEditController.clear();
  }

  Future<void> onSearchTextChanged(String text) async {
    setAPIState(Status.loading);
    searchBillableWeightList.clear();
    if (text.isEmpty) {
      searchBillableWeightList.addAll(billableWeightList);
      setAPIState(searchBillableWeightList.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      return;
    }

    for (final order in billableWeightList) {
      if ('${order.mbnId}'.startsWith(text)) {
        searchBillableWeightList.add(order);
      }
    }
    setAPIState(searchBillableWeightList.isEmpty
        ? Status.successWithEmptyList
        : Status.success);
  }
}
