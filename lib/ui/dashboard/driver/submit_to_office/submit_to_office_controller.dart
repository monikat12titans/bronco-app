import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/success_error_controller.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/widget/animated_icon_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitToOfficeController extends GetxController with APIState {
  List<OrderData> checkInList = [];
  UserData userData = UserData.empty();

  @override
  void onReady() {
    super.onReady();
    getOrderList();
  }

  Future<void> getOrderList() async {
    setAPIState(Status.loading);
    checkInList.clear();
    userData = await AppComponentBase.instance.sharedPreference.getUserData();
    AppComponentBase.instance.showProgressDialog();
    final OrderListResponse orderListResponse = await AppComponentBase
        .instance.apiProvider
        .getPickUpCheckListForSubmitOffice(userData.userid ?? '0');

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      var orderList = orderListResponse.data!
          .where((element) => element.orderStatus == '2');
      checkInList.addAll(orderList);

      setAPIState(
          checkInList.isEmpty ? Status.successWithEmptyList : Status.success);
    } else {
      setAPIState(Status.error, orderListResponse.message);
    }

    AppComponentBase.instance.hideProgressDialog();
  }

  Future<void> tapOnSubmit() async {
    AppComponentBase.instance.showProgressDialog();
    List<String> listMBN = [];
    for (var i = 0; i < checkInList.length; i++) {
      listMBN.add(checkInList[i].mbn ?? '0');
    }

    final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
        .dropAtCityOffice(listMBN, int.parse(userData.userid ?? ''));

    AppComponentBase.instance.hideProgressDialog();
    if (kIsWeb) {
      SuccessErrorController controller = SuccessErrorController();
      Future.delayed(const Duration(milliseconds: 600))
          .then((value) => controller.onInit());
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: '',
        content: AnimatedIconName(
            isSuccess: isSuccess,
            message: message,
            successErrorController: controller,
            uploadFrom: UploadFrom.pickUpSubmitToOfficeSubmit),
      ).then((value) => Get.back());
    } else {
      Get.offAndToNamed(RouteName.successError, arguments: {
        Constant.argumentIsSuccess: apiStatus.isOKay,
        Constant.argumentMessage: apiStatus.message,
        Constant.argumentFrom: UploadFrom.pickUpSubmitToOfficeSubmit.index
      });
    }
  }

  Future<void> onItemTap(OrderData data, bool isForPickUp) async {
    Get.toNamed(RouteName.uploadPOD, arguments: {
      Constant.argumentMBN: data.mbn,
      Constant.argumentFrom: UploadFrom.pickUpSubmitToOffice.index,
      Constant.argumentProductImage:
          isForPickUp ? data.pickUpDriverProduct : data.deliveryDriverProduct,
      Constant.argumentSignature: isForPickUp
          ? data.pickUpDriverSignature
          : data.deliveryDriverSignature
    });
  }
}
