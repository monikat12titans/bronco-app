import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/admin/search/search_controller.dart';
import 'package:bronco_trucking/ui/dashboard/admin/widget/responsive_check_in_list_item.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends GetResponsiveView<MySearchController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              if (screen.isDesktop)
                WebHeader(
                  headerTitle: StringConstants.labelSelectMAWB,
                  hasSearch: true,
                  onSearchTextChange: controller.onSearchTextChanged,
                  searchTextEditController: controller.searchTextEditController,
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: SearchBox(
                          textEditingController:
                              controller.searchTextEditController,
                          onChange: controller.onSearchTextChanged,
                          hintText: StringConstants.hintSearchHouseNumber,
                          textInputType: TextInputType.text,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: Center(
                            child: Obx(() {
                              if (controller.isLoading) {
                                return CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.of(Get.context!)
                                          .primaryColor
                                          .withOpacity(0.8)),
                                  strokeWidth: 5.w,
                                );
                              }
                              if (controller.isSuccess) {
                                return Icon(
                                  Icons.check_circle,
                                  color: Colors.green.withOpacity(0.5),
                                );
                              }
                              if (controller.isError) {
                                return Icon(
                                  Icons.cancel,
                                  color: Colors.red.withOpacity(0.5),
                                );
                              }
                              if (controller.isSuccessWithEmptyList) {
                                return Icon(
                                  Icons.warning_amber_sharp,
                                  color: Colors.amber.withOpacity(0.5),
                                );
                              }
                              return const Offstage();
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              Expanded(
                child: Obx(() {
                  if (controller.isSuccess) {
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              screen.isDesktop ? Constant.webPadding : 15),
                      itemBuilder: (_, index) {
                        var data = controller.searchList.value[index];
                        return ResponsiveCheckInListItem(
                          isHighlightedMBN: true,
                          highlightedText:
                              controller.searchTextEditController.text,
                          orderData: data,
                          onTap: () => Get.toNamed(
                            RouteName.checkInListDetail,
                            arguments: data,
                          ),
                        );
                      },
                      separatorBuilder: (_, index) {
                        return const Divider(
                          height: 2,
                        );
                      },
                      itemCount: controller.searchList.value.length > 4
                          ? 4
                          : controller.searchList.value.length,
                    );
                  }
                  if (controller.isError) {
                    return ErrorText(
                      errorMessage: controller.errorText,
                    );
                  }
                  if (controller.isIdeal) {
                    return Center(
                        child: Text(
                      StringConstants.msgSearchText,
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                    ));
                  }
                  return const Offstage();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
