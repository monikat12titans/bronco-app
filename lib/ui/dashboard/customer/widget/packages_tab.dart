import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_controller.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/packages_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShipmentsTab extends StatelessWidget {
  final bool isDesktop;

  const ShipmentsTab({
    Key? key,
    required this.isDesktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerDashboardController controller =
        Get.find<CustomerDashboardController>();

    return isDesktop
        ? Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Obx(() => ListView.separated(
                        padding: const EdgeInsets.only(top: 0, bottom: 40),
                        itemBuilder: (_, index) {
                          return PackagesListItem(
                              onTap: () => Get.toNamed(RouteName.packageDetail,
                                  arguments: controller.packageList[index]),
                              orderData: controller.packageList[index]);
                        },
                        separatorBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              height: 10,
                              thickness: 10,
                              color: AppTheme.of(context).primaryColor,
                            ),
                          );
                        },
                        itemCount: controller.initialTabLabelIndex.value != -1
                            ? controller.packageList.length
                            : controller.packageList.length > 3
                                ? 3
                                : controller.packageList.length,
                      )),
                ),
                Expanded(
                  child: Obx(() => controller.initialTabLabelIndex.value == -1
                      ? Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LatestPOD(controller: controller),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const Offstage()),
                ),
              ],
            ),
          )
        : ListView(
            padding: const EdgeInsets.only(bottom: 50),
            children: [
              Obx(() => ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return PackagesListItem(
                          onTap: () => Get.toNamed(RouteName.packageDetail,
                              arguments: controller.packageList[index]),
                          orderData: controller.packageList[index]);
                    },
                    separatorBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 10,
                          thickness: 10,
                          color: AppTheme.of(context).primaryColor,
                        ),
                      );
                    },
                    itemCount: controller.initialTabLabelIndex.value != -1
                        ? controller.packageList.length
                        : controller.packageList.length > 3
                            ? 3
                            : controller.packageList.length,
                  )),
              const SizedBox(
                height: 20,
              ),
              Obx(() => controller.initialTabLabelIndex.value == -1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(
                            height: 5,
                            color: Colors.black26,
                            thickness: 0.7,
                          ),
                          LatestPOD(controller: controller),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  : const Offstage()),
            ],
          );
  }
}

class LatestPOD extends StatelessWidget {
  final CustomerDashboardController controller;

  const LatestPOD({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerDashboardController controller =
        Get.find<CustomerDashboardController>();
    return Obx(() => ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          elevation: 0,
          expansionCallback: (int index, bool isExpanded) {
            controller.toExpandPOD(hasExpand: !isExpanded);
          },
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(SVGPath.star),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        StringConstants.labelLatestPOD.toUpperCase(),
                        style: TextStyle(
                            fontFamily: FontFamily.OpenSans,
                            color: const Color(0xff536172),
                            fontSize: 40.sp,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network('https://picsum.photos/250?image=9'),
              ),
              isExpanded: controller.isExpandedPOD.value,
            ),
          ],
        ));
  }
}
