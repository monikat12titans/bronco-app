import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/driver_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/admin/assign_driver/select_driver/select_driver_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDriverPage extends GetResponsiveView<SelectDriverController> {
  @override
  Widget? builder() {
    List<String> selectedMBNId = Get.arguments as List<String>;
    print('-----SelectedMBN Id: $selectedMBNId');
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screen.isDesktop ? 5 : 50),
        child: FloatingActionButton.extended(
          onPressed: () async {
            var data = await Get.toNamed(RouteName.addDriver);
            if (data != null && data is bool && data) {
              controller.getDriverListAPI();
            }
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
        ),
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
                onSearchTextChange: controller.onSearchTextChanged,
                searchTextEditController: controller.searchTextEditController,
                hasSearch: true,
                headerTitle: StringConstants.labelSelectDriver,
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  StringConstants.labelSelectDriver,
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
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.isDesktop ? Constant.webPadding : 15),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: AppTheme.of(Get.context!).primaryColor,
                    child: Obx(() {
                      if (controller.isSuccess &&
                          controller.searchDriverList.isNotEmpty) {
                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 60),
                          itemBuilder: (_, index) {
                            DriverData data =
                                controller.searchDriverList[index];
                            return InkWell(
                              onTap: () => controller.onRadioTap(data),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => BroncoRadio(
                                          isSelected: data.isSelected.value),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Text(
                                        data.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 50.sp,
                                            color: Colors.black87,
                                            fontFamily: FontFamily.OpenSans),
                                      ),
                                    )
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
                          itemCount: controller.searchDriverList.length,
                        );
                      }
                      if (controller.isSuccessWithEmptyList) {
                        return const EmptyListErrorText();
                      }
                      if (controller.isError) return const ErrorText();
                      return const Offstage();
                    }),
                  ),
                ),
              ),
            ),
            if (screen.isDesktop)
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(21),
                  child: BroncoButton(
                    onPress: () => controller.btnSubmitTap(selectedMBNId),
                    text: StringConstants.btnSubmit.toUpperCase(),
                    hasGradientBg: false,
                    blurRadius: 0,
                    width: 120,
                    rounder: 30,
                  ),
                ),
              )
            else
              BroncoButton(
                onPress: () => controller.btnSubmitTap(selectedMBNId),
                text: StringConstants.btnSubmit.toUpperCase(),
                hasGradientBg: false,
                blurRadius: 0,
                rounder: 0,
              )
          ],
        ),
      ),
    );
  }
}
