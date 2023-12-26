import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_controller.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/invoices_tab.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/message_tab.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/packages_tab.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/responsive_toggle_icon_text.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDashboardPage
    extends GetResponsiveView<CustomerDashboardController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Obx(() =>
          controller.initialTabLabelIndex.value == -1 ||
                  controller.previewOutstandingInvoiceSelected.value != -1
              ? MakeAPayment(
                  controller: controller,
                  isDesktop: screen.isDesktop,
                )
              : const Offstage()),
      body: Obx(
        () => BroncoAppBar(
          isDeskTop: screen.isDesktop,
          onLogoutTap: () => controller.btnLogoutTap(),
          hasLogout: !screen.isDesktop,
          hasBack: controller.initialTabLabelIndex.value != -1,
          onBackTap: () {
            controller.initialTabLabelIndex.value = -1;
            controller.selectedTab.value = 0;
            controller.previewOutstandingInvoiceSelected.value = -1;
          },
          child: screen.isDesktop
              ? DesktopDashboard(
                  customerDashboardController: controller,
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ResponsiveToggleIconText(
                        isDesktop: false,
                        text: controller.label,
                        imgPath: controller.pngs,
                        selectedIndex: controller.selectedTabIndex,
                        onSelected: (int index) =>
                            controller.onTabChange(index)),
                    Expanded(
                      child: ResponsiveDashBoardIndexBody(
                        controller: controller,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MakeAPayment extends StatelessWidget {
  final CustomerDashboardController controller;
  final bool isDesktop;

  const MakeAPayment(
      {required this.controller, required this.isDesktop, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton.extended(
        elevation: 2,
        onPressed: () => controller.onMakeAPaymentTap(isDesktop: isDesktop),
        backgroundColor: AppTheme.of(Get.context!).primaryColor,
        icon: const Icon(Icons.account_balance_wallet),
        label: Text(
          StringConstants.makePayment.toUpperCase(),
          style: const TextStyle(
              fontFamily: FontFamily.OpenSans, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class DesktopDashboard extends StatelessWidget {
  final CustomerDashboardController customerDashboardController;

  const DesktopDashboard({required this.customerDashboardController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.2,
              child: ResponsiveToggleIconText(
                  onLogOut: () => customerDashboardController.btnLogoutTap(),
                  isDesktop: true,
                  text: customerDashboardController.label,
                  imgPath: customerDashboardController.pngs,
                  selectedIndex: customerDashboardController.selectedTabIndex,
                  onSelected: (int index) {
                    customerDashboardController.onTabChange(index);
                  }),
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: ResponsiveDashBoardIndexBody(
                controller: customerDashboardController,
                isDeskTop: true,
              ),
            ),
          ],
        ),
        Obx(() {
          if (customerDashboardController.initialTabLabelIndex.value != -1) {
            return Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: InkWell(
                onTap: () {
                  customerDashboardController.initialTabLabelIndex.value = -1;
                  customerDashboardController.selectedTab.value = 0;
                  customerDashboardController
                      .previewOutstandingInvoiceSelected.value = -1;
                },
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                    size: 25,
                  ),
                ),
              ),
            );
          }
          return const Offstage();
        }),
      ],
    );
  }
}

class ResponsiveDashBoardIndexBody extends StatelessWidget {
  final bool isDeskTop;
  final CustomerDashboardController controller;

  const ResponsiveDashBoardIndexBody({
    required this.controller,
    Key? key,
    this.isDeskTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: controller.selectedTab.value,
      children: [
        Obx(() {
          if (controller.isSuccess) {
            return ShipmentsTab(
              isDesktop: isDeskTop,
            );
          }
          if (controller.isSuccessWithEmptyList) {
            return const EmptyListErrorText();
          }
          if (controller.isError) {
            return ErrorText(
              errorMessage: controller.errorMessage,
            );
          }
          return const Offstage();
        }),
        Obx(() {
          switch (Status.values[controller.invoiceTabState.value]) {
            case Status.ideal:
            case Status.loading:
              return const Offstage();
            case Status.success:
              return InvoicesTab(
                isDesktop: isDeskTop,
              );
            case Status.error:
              return const ErrorText();
            case Status.successWithEmptyList:
              return const EmptyListErrorText();
          }
        }),
        Obx(() {
          switch (Status.values[controller.messageTabState.value]) {
            case Status.ideal:
            case Status.loading:
              return const Offstage();
            case Status.success:
            case Status.successWithEmptyList:
            case Status.error:
              return Padding(
                padding: EdgeInsets.symmetric(vertical: isDeskTop ? 30.0 : 0),
                child: const MessageTab(),
              );
          }
        }),
      ],
    );
  }
}
