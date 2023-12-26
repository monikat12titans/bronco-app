import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/admin/admin_dashboard_controller.dart';
import 'package:bronco_trucking/ui/dashboard/admin/widget/list_header_label.dart';
import 'package:bronco_trucking/ui/dashboard/admin/widget/responsive_check_in_list_item.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AdminDashboardPage extends GetResponsiveView<AdminDashboardController> {
  @override
  Widget? builder() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BroncoAppBar(
        onLogoutTap: () => controller.btnLogoutTap(),
        hasLogout: true,
        hasBack: false,
        hasSearchIcon: true,
        isDeskTop: screen.isDesktop,
        onSearchTap: () => Get.toNamed(RouteName.search),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screen.isDesktop
                  ? Constant.webPadding
                  : Constant.appHorizontalPadding),
          child: ResponsiveAdmin(
            isDesktop: screen.isDesktop,
          ),
        ),
      ),
    );
  }
}

class ResponsiveAdmin extends StatelessWidget {
  final bool isDesktop;

  const ResponsiveAdmin({this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    final AdminDashboardController controller =
        Get.find<AdminDashboardController>();
    return isDesktop
        ? Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        SVGPath.icon,
                        color: AppTheme.of(context).primaryColor,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Text(
                      StringConstants.labelDashboard,
                      style: TextStyle(
                          fontFamily: FontFamily.OpenSans,
                          fontWeight: FontWeight.w800,
                          fontSize: 65.sp,
                          color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _WebHeader(controller: controller),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    child: Column(
                      children: [
                        Obx(() => controller.orderList.isEmpty
                            ? const Offstage()
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    StringConstants.labelCheckInList,
                                    style: TextStyle(
                                        fontFamily: FontFamily.OpenSans,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 50.sp,
                                        color: Colors.black),
                                  ),
                                ),
                              )),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => Expanded(
                              child: Column(
                                children: [
                                  ListHeader(),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      itemBuilder: (_, index) {
                                        var data =
                                            controller.orderList.value[index];
                                        return ResponsiveCheckInListItem(
                                          isDesktop: true,
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
                                      itemCount:
                                          controller.orderList.value.length > 8
                                              ? 8
                                              : controller
                                                  .orderList.value.length,
                                    ),
                                  )
                                ],
                              ),
                            )),
                        Obx(
                          () => controller.orderList.value.length > 8
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                        RouteName.adminCheckInList,
                                        arguments: controller.orderList.value),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        StringConstants.labelSeeAll,
                                        style: TextStyle(
                                            fontFamily: FontFamily.OpenSans,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 30.sp,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                )
                              : const Offstage(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 30,
              ),
              BroncoButton(
                onPress: () => controller.btnAddHouseNumberTap(false),
                text: StringConstants.btnAddHouseNumber.toUpperCase(),
              ),
              const SizedBox(
                height: 30,
              ),
              BroncoButton(
                onPress: () => controller.btnAddPackageTap(false),
                text: StringConstants.btnAddShipment.toUpperCase(),
              ),
              SizedBox(
                height: 50.h,
              ),
              Obx(() => controller.orderList.isEmpty
                  ? const Offstage()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        StringConstants.labelCheckInList,
                        style: TextStyle(
                            fontFamily: FontFamily.OpenSans,
                            fontWeight: FontWeight.w800,
                            fontSize: 50.sp,
                            color: Colors.black87),
                      ),
                    )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      var data = controller.orderList.value[index];
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
                    itemCount: controller.orderList.value.length > 4
                        ? 4
                        : controller.orderList.value.length,
                  )),
              Obx(
                () => controller.orderList.value.length > 4
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteName.adminCheckInList,
                              arguments: controller.orderList.value),
                          child: Text(
                            StringConstants.labelSeeAll,
                            style: TextStyle(
                                fontFamily: FontFamily.OpenSans,
                                fontWeight: FontWeight.w800,
                                fontSize: 30.sp,
                                color: Colors.black54),
                          ),
                        ),
                      )
                    : const Offstage(),
              ),
              const SizedBox(
                height: 20,
              ),
              BroncoButton(
                onPress: () => Get.toNamed(RouteName.adminBillableWeight),
                text: StringConstants.btnAddBillableWeight,
              ),
              SizedBox(
                height: 50.h,
              ),
              BroncoButton(
                onPress: () => Get.toNamed(RouteName.adminSelectMAWB),
                text: StringConstants.btnAssignToDriver,
              ),
              SizedBox(
                height: 50.h,
              ),
              BroncoButton(
                onPress: () =>
                    Get.toNamed(RouteName.adminSelectMAWB, arguments: false),
                text: StringConstants.btnAssignToCustomer,
              ),
              SizedBox(
                height: 50.h,
              ),
              BroncoButton(
                onPress: () => Get.toNamed(RouteName.adminMessages),
                text: StringConstants.btnMessage,
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 50.h,
              ),
              /*  BroncoButton(
                onPress: () => Get.toNamed(RouteName.adminInvoiceList),
                text: StringConstants.btnInvoices,
              ),*/
            ],
          );
  }
}

class ListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: const [
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  label: StringConstants.labelHouseNumber,
                )),
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  label: StringConstants.labelMAWB,
                )),
            Expanded(
                flex: 2,
                child: ListHeaderLabel(
                  label: StringConstants.labelCheckIn,
                )),
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  label: StringConstants.labelTime,
                )),
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  label: StringConstants.labelWeightHeightLength,
                )),
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  label: StringConstants.labelAssignedDriver,
                ))
          ],
        ),
      ),
    );
  }
}

class _WebHeader extends StatelessWidget {
  const _WebHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AdminDashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: BroncoButton(
            height: 80,
            rounder: 5,
            blurRadius: 0.1,
            onPress: () => controller.btnAddHouseNumberTap(true),
            text: StringConstants.btnAddHouseNumber,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: BroncoButton(
            height: 80,
            rounder: 5,
            blurRadius: 0.1,
            onPress: () => controller.btnAddPackageTap(false),
            text: StringConstants.btnAddShipment,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: BroncoButton(
            height: 80,
            rounder: 5,
            blurRadius: 0.1,
            onPress: () => Get.toNamed(RouteName.adminBillableWeight),
            text: StringConstants.btnAddBillableWeight,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: BroncoButton(
            height: 80,
            rounder: 5,
            blurRadius: 0.1,
            onPress: () => Get.toNamed(RouteName.adminSelectMAWB),
            text: StringConstants.btnAssignToDriver,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: BroncoButton(
            height: 80,
            rounder: 5,
            blurRadius: 0.1,
            onPress: () =>
                Get.toNamed(RouteName.adminSelectMAWB, arguments: false),
            text: StringConstants.btnAssignToCustomer,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: BroncoButton(
            height: 80,
            rounder: 5,
            blurRadius: 0.1,
            onPress: () => Get.toNamed(RouteName.adminMessages),
            text: StringConstants.btnMessage,
          ),
        ),
      ],
    );
  }
}
