import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../admin_dashboard_controller.dart';

class AdminCheckInListController extends GetxController with APIState {
  List<OrderData> orderList = <OrderData>[];
  List<OrderData> searchOrderList = <OrderData>[];
  bool isNeedAPICall = false;
  TextEditingController searchTextEditController = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments is Map<String, dynamic>) {
      var argument = Get.arguments as Map<String, dynamic>;
      isNeedAPICall = argument[Constant.argumentIsNeedAPICall] as bool;
      orderList = argument[Constant.argumentList] as List<OrderData>;
    }
    if (Get.arguments is List<OrderData>) {
      orderList = Get.arguments as List<OrderData>;
      searchOrderList.addAll(orderList);
      setAPIState(Status.success);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (isNeedAPICall) getOrderListAPI();
  }

  Future<void> getOrderListAPI() async {
    setAPIState(Status.loading);
    final AdminDashboardController controller =
        Get.find<AdminDashboardController>();

    await controller.getOrderList();
    orderList.clear();
    searchOrderList.clear();
    orderList = controller.orderList;
    searchOrderList.addAll(orderList);

    setAPIState(
        searchOrderList.isEmpty ? Status.successWithEmptyList : Status.success);
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
      if (order.houseNumber!.contains(text)) {
        searchOrderList.add(order);
      }
    }
    setAPIState(
        searchOrderList.isEmpty ? Status.successWithEmptyList : Status.success);
  }
}
