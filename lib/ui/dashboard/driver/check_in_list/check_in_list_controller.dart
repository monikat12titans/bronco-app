import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckInListController extends GetxController with APIState {
  List<OrderData> newItem = [];
  List<OrderData> myItem = [];
  List<OrderData> searchNewItemInList = [];
  List<OrderData> searchMyItemInList = [];
  TextEditingController searchTextEditController = TextEditingController();
  RxBool isForPickUp = false.obs;
  String errorMessage = StringConstants.errorSomethingWentWrong2;

  void btnLogoutTap() {
    AppComponentBase.instance.sharedPreference.clearData();
    Get.offAllNamed(RouteName.loginPage);
  }

  @override
  void onInit() {
    super.onInit();
    isForPickUp = (Get.arguments as bool).obs;
  }

  Future<void> getOrderList({bool isPickup = true}) async {
    setAPIState(Status.loading);

    newItem.clear();
    myItem.clear();
    searchMyItemInList.clear();
    searchNewItemInList.clear();

    AppComponentBase.instance.showProgressDialog();

    UserData userData =
        await AppComponentBase.instance.sharedPreference.getUserData();

    final OrderListResponse orderListResponse = isPickup
        ? await AppComponentBase.instance.apiProvider
            .getPickUpCheckList(userData.userid ?? '0')
        : await AppComponentBase.instance.apiProvider
            .getDeliveryDriverCheckList(userData.userid ?? '0');

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      newItem.addAll(orderListResponse.newItem);
      searchNewItemInList.addAll(newItem);

      if (isPickup) {
        myItem.addAll(orderListResponse.myItem.toList());
        searchMyItemInList.addAll(myItem);
      }
      if (isPickup) {
        setAPIState(searchNewItemInList.isEmpty && searchMyItemInList.isEmpty
            ? Status.successWithEmptyList
            : Status.success);
      } else {
        setAPIState(searchNewItemInList.isEmpty
            ? Status.successWithEmptyList
            : Status.success);
      }
    } else {
      errorMessage = orderListResponse.errorMessage;
      setAPIState(Status.error);
      // Utils.displaySnack(message: orderListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  Future<void> onSearchTextChanged(String text) async {
    setAPIState(Status.loading);
    searchNewItemInList.clear();
    if (isForPickUp.isTrue) searchMyItemInList.clear();
    if (text.isEmpty) {
      searchNewItemInList.addAll(newItem);
      if (isForPickUp.isTrue) searchMyItemInList.addAll(myItem);

      var status = isForPickUp.isTrue
          ? searchNewItemInList.isEmpty && searchMyItemInList.isEmpty
          : searchNewItemInList.isEmpty;
      setAPIState(status ? Status.successWithEmptyList : Status.success);
      return;
    }

    for (final order in newItem) {
      if (order.mbn!.startsWith(text)) {
        searchNewItemInList.add(order);
      }
    }
    if (isForPickUp.isTrue) {
      for (final order in myItem) {
        if (order.mbn!.startsWith(text)) {
          searchMyItemInList.add(order);
        }
      }

      var status = isForPickUp.isTrue
          ? searchNewItemInList.isEmpty && searchMyItemInList.isEmpty
          : searchNewItemInList.isEmpty;
      setAPIState(status ? Status.successWithEmptyList : Status.success);
    }else{
      setAPIState(searchNewItemInList.isEmpty ? Status.successWithEmptyList : Status.success);

    }
  }

  Future<void> onItemTap(OrderData data, bool isForPickUp) async {
    Get.toNamed(RouteName.uploadPOD, arguments: {
      Constant.argumentMBN: data.mbn,
      Constant.argumentFrom: isForPickUp
          ? UploadFrom.pickUpCheckIn.index
          : UploadFrom.delivery.index,
      //  Constant.argumentIsPickUp: isForPickUp,
      // Constant.argumentIsAssignedToPickUpDriver: data.isAssignedToPickUpDriver,
      Constant.argumentProductImage:
          isForPickUp ? data.pickUpDriverProduct : data.deliveryDriverProduct,
      Constant.argumentSignature: isForPickUp
          ? data.pickUpDriverSignature
          : data.deliveryDriverSignature
    });
  }
}
