import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/house_data.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enter_mawb_controller.dart';

class EnterMAWBPage extends GetView<EnterMAWBController> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> mawbForm = GlobalKey<FormState>();

    return Scaffold(
      body: BroncoAppBar(
        onBackTap: () => Get.back(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: mawbForm,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                  children: [
                    BroncoTextFormField(
                      keyboardType: TextInputType.number,
                      validator: controller.emptyValidator,
                      hintText: StringConstants.hintMAWB,
                      controller: controller.mawbTextEditController,
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.red[800],
                        fontFamily: FontFamily.OpenSans,
                        fontSize: 30.sp,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(
                      () => controller.isHouseListFetched.value
                          ? _buildDropDown()
                          : const Offstage(),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            BroncoButton(
              rounder: 0,
              blurRadius: 0,
              hasGradientBg: false,
              text: StringConstants.btnSubmit.toUpperCase(),
              onPress: () {
                controller.btnSubmitTap(mawbForm, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        border: Border.all(color: Colors.white54),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => DropdownBelow<HouseData?>(
              itemWidth: Get.width - 80.h,
              itemTextstyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: FontFamily.OpenSans,
                fontSize: 40.sp,
              ),
              boxTextstyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: FontFamily.OpenSans,
                fontSize: 40.sp,
              ),
              boxPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              boxWidth: Get.width,
              boxHeight: 140.h,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              hint: const Text('Select House Number'),
              value: controller.selectedHouseData.value,
              items: _buildDropDownItems(),
              onChanged: controller.onChanged,
            ),
          ),
          Obx(
            () => controller.isValueSelected.value
                ? const Offstage()
                : _buildSelectionError(),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<HouseData?>> _buildDropDownItems() {
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
}
