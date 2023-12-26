import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/driver/check_in_list/check_in_list_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckInListPage extends GetResponsiveView<CheckInListController> {
  @override
  Widget? builder() {
    controller.getOrderList(isPickup: controller.isForPickUp.isTrue);
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        hasLogout: !screen.isDesktop,
        onLogoutTap: () => controller.btnLogoutTap(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screen.isDesktop ? 15 : 20,
            ),
            if (screen.isDesktop)
              WebHeader(
                bottomPadding: EdgeInsets.zero,
                searchTextEditController: controller.searchTextEditController,
                hasSearch: true,
                searchHintText: StringConstants.hintSearchMAWBNumber,
                headerTitle:
                    '${controller.isForPickUp.isTrue ? StringConstants.labelCheckInList : StringConstants.labelDeliveryList} ',
                onSearchTextChange: controller.onSearchTextChanged,
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '${controller.isForPickUp.isTrue ? StringConstants.labelCheckInList : StringConstants.labelDeliveryList} ',
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
                  onChange: controller.onSearchTextChanged,
                  hintText: StringConstants.hintSearchMAWBNumber,
                  textInputType: TextInputType.number,
                  textEditingController: controller.searchTextEditController,
                ),
              ),
            ],
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: AppTheme.of(Get.context!).primaryColor,
                  child: Obx(() {
                    if (controller.isForPickUp.isTrue && controller.isSuccess) {
                      return ResponsiveCheckInList(
                        controller: controller,
                        isDesktop: screen.isDesktop,
                      );
                    }
                    if (controller.isSuccess) {
                      return ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            var data = controller.searchNewItemInList[index];
                            return InkWell(
                              onTap: () => controller.onItemTap(
                                  data, controller.isForPickUp.value),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Text(
                                  '${StringConstants.labelMAWB} #${data.mbn}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 50.sp,
                                      color: Colors.black87,
                                      fontFamily: FontFamily.OpenSans),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const Divider(
                              height: 2,
                            );
                          },
                          itemCount: controller.searchNewItemInList.length);
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResponsiveCheckInList extends StatelessWidget {
  const ResponsiveCheckInList({
    Key? key,
    required this.controller,
    this.isDesktop = false,
  }) : super(key: key);

  final CheckInListController controller;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? Row(
            children: [
              SizedBox(
                  width: Get.width * 0.499,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: Constant.webPadding),
                        child: Text(
                          StringConstants.labelNewItem.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 55.sp,
                              color: Colors.black87,
                              fontFamily: FontFamily.OpenSans),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            //shrinkWrap: true,
                            //padding: const EdgeInsets.symmetric(horizontal: 2),
                            itemBuilder: (_, index) {
                              var data = controller.searchNewItemInList[index];
                              return InkWell(
                                onTap: () => controller.onItemTap(
                                    data, controller.isForPickUp.value),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: Constant.webPadding),
                                  child: Text(
                                    '${StringConstants.labelMAWB} #${data.mbn}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 50.sp,
                                        color: Colors.black87,
                                        fontFamily: FontFamily.OpenSans),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                height: 2,
                              );
                            },
                            itemCount: controller.searchNewItemInList.length),
                      )
                    ],
                  )),
              Container(
                width: Get.width * 0.001,
                color: Colors.black54,
                height: double.infinity,
              ),
              SizedBox(
                  width: Get.width * 0.499,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 22),
                        child: Text(
                          StringConstants.labelMyItem.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 55.sp,
                              color: Colors.black87,
                              fontFamily: FontFamily.OpenSans),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (_, index) {
                              var data = controller.searchMyItemInList[index];
                              return InkWell(
                                onTap: () => controller.onItemTap(
                                    data, controller.isForPickUp.value),
                                child: ColoredBox(
                                  color: data.hasProductImageAndSignature
                                      ? AppTheme.of(Get.context!)
                                          .primaryColor
                                          .withOpacity(0.8)
                                      : Colors.yellow.withOpacity(0.8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    child: Text(
                                      '${StringConstants.labelMAWB} #${data.mbn}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 50.sp,
                                          color: Colors.black87,
                                          fontFamily: FontFamily.OpenSans),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                height: 2,
                              );
                            },
                            itemCount: controller.searchMyItemInList.length),
                      ),
                    ],
                  ))
            ],
          )
        : ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: [
              ColoredBox(
                color: Colors.black.withOpacity(0.3),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    StringConstants.labelNewItem.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 55.sp,
                        color: Colors.black87,
                        fontFamily: FontFamily.OpenSans),
                  ),
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (_, index) {
                    var data = controller.searchNewItemInList[index];
                    return InkWell(
                      onTap: () => controller.onItemTap(
                          data, controller.isForPickUp.value),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Text(
                          '${StringConstants.labelMAWB} #${data.mbn}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 50.sp,
                              color: Colors.black87,
                              fontFamily: FontFamily.OpenSans),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(
                      height: 2,
                    );
                  },
                  itemCount: controller.searchNewItemInList.length),
              ColoredBox(
                color: Colors.black.withOpacity(0.3),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    StringConstants.labelMyItem.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 55.sp,
                        color: Colors.black87,
                        fontFamily: FontFamily.OpenSans),
                  ),
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    var data = controller.searchMyItemInList[index];
                    return InkWell(
                      onTap: () => controller.onItemTap(
                          data, controller.isForPickUp.value),
                      child: ColoredBox(
                        color: data.hasProductImageAndSignature
                            ? AppTheme.of(Get.context!)
                                .primaryColor
                                .withOpacity(0.8)
                            : Colors.yellow.withOpacity(0.8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Text(
                            '${StringConstants.labelMAWB} #${data.mbn}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 50.sp,
                                color: Colors.black87,
                                fontFamily: FontFamily.OpenSans),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(
                      height: 2,
                    );
                  },
                  itemCount: controller.searchMyItemInList.length),
            ],
          );
  }
}
