import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/admin/select_mawb/select_mawb_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMAWBPage extends GetResponsiveView<SelectMAWBController> {
  @override
  Widget? builder() {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screen.isDesktop ? 55 : 50),
        child: controller.isFromDriver
            ? FloatingActionButton.extended(
                elevation: 0,
                onPressed: () async {
                  Get.toNamed(RouteName.addDriver);
                  /*if (data != null && data is bool && data) {
              controller.getDriverListAPI();
            }*/
                },
                backgroundColor: AppTheme.of(Get.context!).primaryColor,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: const Text(
                  StringConstants.addDriver,
                  style: TextStyle(color: Colors.white),
                ),
              )
            : null,
      ),
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            if (screen.isDesktop)
              WebHeader(
                headerTitle: StringConstants.labelSelectMAWB,
                hasSearch: true,
                searchTextEditController: controller.searchTextEditController,
                onSearchTextChange: controller.onSearchTextChanged,
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  StringConstants.labelSelectMAWB,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 70.sp,
                      letterSpacing: 1.5,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SearchBox(
                  textEditingController: controller.searchTextEditController,
                  onChange: controller.onSearchTextChanged,
                  hintText: StringConstants.hintSearchMAWBNumber,
                  textInputType: TextInputType.number,
                ),
              ),
            ],
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(() {
                if (controller.isSuccess) {
                  return ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: AppTheme.of(Get.context!).primaryColor,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                screen.isDesktop ? Constant.webPadding : 15,
                            vertical: 2),
                        itemBuilder: (_, index) {
                          var data = controller.searchOrderList[index];
                          return InkWell(
                            onTap: () => controller.onRadioTap(data),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: BroncoRadio(
                                          isSelected: data.isSelected.value),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${StringConstants.labelMAWB} #${data.mbn}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 50.sp,
                                            color: Colors.black87,
                                            fontFamily: FontFamily.OpenSans),
                                      ),
                                      if (controller.isFromDriver &&
                                          data.assignDriverName!.isNotEmpty)
                                        Text(
                                          '${StringConstants.labelAssignedDriver}  : ${data.assignDriverName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 30.sp,
                                              color: Colors.black87,
                                              fontFamily: FontFamily.OpenSans),
                                        ),
                                      if (!controller.isFromDriver &&
                                          data.assignCustomerName!.isNotEmpty)
                                        Text(
                                          '${StringConstants.labelAssignedCustomer}  : ${data.assignCustomerName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 30.sp,
                                              color: Colors.black87,
                                              fontFamily: FontFamily.OpenSans),
                                        ),
                                      //  if(!controller.isFromDriver && data.ass)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const Divider(
                            height: 2,
                          );
                        },
                        itemCount: controller.searchOrderList.length,
                      ),
                    ),
                  );
                }
                if (controller.isSuccessWithEmptyList) {
                  return const EmptyListErrorText();
                }
                if (controller.isError) {
                  return ErrorText(
                    errorMessage: controller.error,
                  );
                }
                return const Offstage();
              }),
            ),
            Obx(() {
              if (controller.isSuccess) {
                if (screen.isDesktop) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: BroncoButton(
                        onPress: () => controller.onSubmitTap(),
                        text: StringConstants.btnNext.toUpperCase(),
                        hasGradientBg: false,
                        blurRadius: 0,
                        width: 110,
                        rounder: 30,
                      ),
                    ),
                  );
                } else {
                  return BroncoButton(
                    onPress: () => controller.onSubmitTap(),
                    text: StringConstants.btnNext.toUpperCase(),
                    hasGradientBg: false,
                    blurRadius: 0,
                    rounder: 0,
                  );
                }
              }
              return const Offstage();
            })
          ],
        ),
      ),
    );
  }
}
