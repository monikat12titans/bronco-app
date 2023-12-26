import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SelectMAWBPaymentController extends GetxController with APIState {
  List<OrderData> orderList = [];
  List<OrderData> searchOrderList = [];
  String previousSelectedId = '-1';
  String error = '';
  TextEditingController searchTextEditController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDeliveryOrderList();
  }

  Future<void> getDeliveryOrderList() async {
    setAPIState(Status.loading);
    orderList.clear();
    searchOrderList.clear();
    UserData userData =
        await AppComponentBase.instance.sharedPreference.getUserData();

    AppComponentBase.instance.showProgressDialog();
    OrderListResponse orderListResponse = await AppComponentBase
        .instance.apiProvider
        .getCustomerOutstandingInvoiceListById(userData.userid ?? '-1');

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      setAPIState(orderListResponse.data!.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      orderList.addAll(orderListResponse.data ?? []);
      searchOrderList.addAll(orderListResponse.data ?? []);
    } else {
      error = orderListResponse.errorMessage;
      setAPIState(Status.error);
      Utils.displaySnack(message: orderListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  Future<void> onSearchTextChanged(String text) async {
    setAPIState(Status.loading);
    searchOrderList.clear();
    if (text.isEmpty) {
      searchOrderList.addAll(orderList);
      setAPIState(searchOrderList.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      return;
    }

    for (final order in orderList) {
      if ('${order.mbn}'.startsWith(text)) {
        searchOrderList.add(order);
      }
    }
    setAPIState(
        searchOrderList.isEmpty ? Status.successWithEmptyList : Status.success);
  }

  void onRadioTap(OrderData orderData) {
    orderData.isSelected.value = !orderData.isSelected.value;
  }

  void onSubmitTap() {
    var selectedMBN =
        searchOrderList.where((element) => element.isSelected.isTrue).toList();
    if (selectedMBN.isNotEmpty) {
      List<String> selectedMBNID = [];
      for (final order in selectedMBN) {
        selectedMBNID.add(order.mbn ?? '0');
      }
      Get.toNamed(RouteName.paymentPage, arguments: selectedMBNID);
    } else {
      Utils.displaySnack(message: StringConstants.errorSelectMAWB);
    }
  }
}
