import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/house_data.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/common/widgets/cancel_button.dart';
import 'package:bronco_trucking/ui/global_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_shipment/add_house_number/add_house_number_controller.dart';
import 'add_shipment/enter_mawb/enter_mawb_controller.dart';

class AdminDashboardController extends GetxController with APIState {
  RxList<OrderData> orderList = <OrderData>[].obs;

  @override
  void onInit() {
    getOrderList();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void btnLogoutTap() {
    Get.find<GlobalController>().btnLogoutTap(Get.context!);
  }

  void btnAddPackageTap(bool isDesktop) {
    if (isDesktop) {
      openDialogForCreateShipment();
    } else {
      Get.toNamed(RouteName.enterMAWBNumber);
    }
  }

  void btnAddHouseNumberTap(bool isDesktop) {
    openDialogForAddingHouseNumber(isDesktop);
  }

  Future<void> getOrderList() async {
    setAPIState(Status.loading);
    orderList.clear();
    AppComponentBase.instance.showProgressDialog();
    final OrderListResponse orderListResponse =
        await AppComponentBase.instance.apiProvider.getOrderList();

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      setAPIState(orderListResponse.data!.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      orderList.addAll(orderListResponse.data!.obs);
    } else {
      setAPIState(Status.error);
      Utils.displaySnack(message: orderListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  void openDialogForCreateShipment() {
    GlobalKey<FormState> mawbForm = GlobalKey<FormState>();

    EnterMAWBController controller = EnterMAWBController();
    controller.getHouseList();
    Get.defaultDialog(
      title: StringConstants.appName,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: mawbForm,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BroncoTextFormField(
                keyboardType: TextInputType.number,
                validator: controller.emptyValidator,
                hintText: StringConstants.hintMAWB,
                controller: controller.mawbTextEditController,
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => controller.isHouseListFetched.value
                    ? _buildDropDown(controller)
                    : const Offstage(),
              ),
            ],
          ),
        ),
      ),
      radius: 5,
      titleStyle: TextStyle(
          fontFamily: FontFamily.OpenSans,
          fontWeight: FontWeight.bold,
          color: AppTheme.of(Get.context!).primaryColor),
      actions: [
        CancelButton(
          onPress: () => Get.back(),
          width: 80.w,
          rounderCorner: 30,
          height: 100.h,
          text: StringConstants.btnCancel,
          blurRadius: 0.1,
        ),
        BroncoButton(
          onPress: () => controller.btnSubmitTap(mawbForm, Get.context!),
          width: 80.w,
          height: 100.h,
          color: AppTheme.of(Get.context!).primaryColor.withOpacity(0.7),
          hasGradientBg: false,
          text: StringConstants.btnSubmit,
          rounder: 30,
          blurRadius: 0.1,
        )
      ],
    );
  }

  Widget _buildDropDown(EnterMAWBController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Obx(
              () => DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<HouseData?>(
                    isExpanded: true,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: FontFamily.OpenSans,
                      fontSize: 40.sp,
                    ),
                    menuMaxHeight: 550.h,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    hint: const Text('Select House Number'),
                    value: controller.selectedHouseData.value,
                    items: _buildDropDownItems(controller),
                    onChanged: controller.onChanged,
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.isValueSelected.value
                  ? const Offstage()
                  : _buildSelectionError(),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<HouseData?>> _buildDropDownItems(
      EnterMAWBController controller) {
    List<DropdownMenuItem<HouseData?>> items = [];
    if (controller.houseList.isNotEmpty) {
      for (final houseData in controller.houseList) {
        items.add(
          DropdownMenuItem(
            value: houseData,
            child: Text(houseData.houseNo.toString()),
          ),
        );
      }
      return items;
    } else {
      return items;
    }
  }

  Widget _buildSelectionError() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Text(
        StringConstants.errorSelectHouse,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.red[800],
          fontFamily: FontFamily.OpenSans,
          fontSize: 30.sp,
        ),
      ),
    );
  }

  void openDialogForAddingHouseNumber(bool isDesktop) {
    GlobalKey<FormState> addHouseNumberForm = GlobalKey<FormState>();

    AddHouseNumberController controller = AddHouseNumberController();
    Get.defaultDialog(
      title: StringConstants.appName,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: addHouseNumberForm,
          child: BroncoTextFormField(
            keyboardType: TextInputType.text,
            validator: controller.emptyValidator,
            maxLength: 10,
            hintText: StringConstants.hintHouseNumber,
            controller: controller.houseNumberTextEditController,
          ),
        ),
      ),
      radius: 5,
      titleStyle: TextStyle(
          fontFamily: FontFamily.OpenSans,
          fontWeight: FontWeight.bold,
          color: AppTheme.of(Get.context!).primaryColor),
      actions: [
        CancelButton(
          onPress: () => {
            FocusScope.of(Get.context!).unfocus(),
            Get.back(),
          },
          width: isDesktop ? 80.w : 250.w,
          rounderCorner: 30,
          height: 100.h,
          text: StringConstants.btnCancel,
          blurRadius: 0.1,
        ),
        BroncoButton(
          onPress: () => {
            FocusScope.of(Get.context!).unfocus(),
            controller.btnAddTap(addHouseNumberForm, Get.context!),
          },
          width: isDesktop ? 80.w : 250.w,
          height: 100.h,
          color: AppTheme.of(Get.context!).primaryColor.withOpacity(0.7),
          hasGradientBg: false,
          text: StringConstants.btnSubmit,
          rounder: 30,
          blurRadius: 0.1,
        )
      ],
    );
  }
}
