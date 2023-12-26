import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/admin_check_in_list_controller.dart';
import 'package:bronco_trucking/ui/dashboard/admin/widget/responsive_check_in_list_item.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCheckInListPage
    extends GetResponsiveView<AdminCheckInListController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.offNamedUntil(RouteName.adminDashboardPage,
            (route) => route.settings.name == RouteName.adminDashboardPage),
        child: Column(
          children: [
            if (screen.isDesktop)
              WebHeader(
                headerTitle: StringConstants.labelCheckIn,
                onSearchTextChange: controller.onSearchTextChanged,
                hasSearch: true,
                searchTextEditController: controller.searchTextEditController,
              )
            else ...[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SearchBox(
                  textInputType: TextInputType.text,
                  hintText: StringConstants.hintSearchHouseNumber,
                  textEditingController: controller.searchTextEditController,
                  onChange: controller.onSearchTextChanged,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
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
                                screen.isDesktop ? Constant.webPadding : 15),
                        itemBuilder: (_, index) {
                          OrderData data = controller.searchOrderList[index];
                          return ResponsiveCheckInListItem(
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
                        itemCount: controller.searchOrderList.length,
                      ),
                    ),
                  );
                }
                if (controller.isSuccessWithEmptyList) {
                  return const EmptyListErrorText();
                }
                if (controller.isError) {
                  return const ErrorText();
                }
                return const Offstage();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
