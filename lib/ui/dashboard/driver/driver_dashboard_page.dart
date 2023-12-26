import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/driver/driver_dashboard_controller.dart';
import 'package:bronco_trucking/ui/dashboard/driver/submit_to_office/submit_to_office_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'submit_to_office/submit_to_office_page.dart';

class DriverDashboardPage extends GetResponsiveView<DriverDashboardController> {
  @override
  Widget? builder() {
    controller.onReady();
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onLogoutTap: () => controller.btnLogoutTap(),
        hasLogout: true,
        hasBack: false,
        child: screen.isDesktop
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constant.webPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            SVGPath.icon,
                            color: AppTheme.of(Get.context!).primaryColor,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Text(
                          StringConstants.labelDriverDashboard,
                          style: TextStyle(
                              fontFamily: FontFamily.OpenSans,
                              fontWeight: FontWeight.w800,
                              fontSize: 65.sp,
                              color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          if (controller.userData.value.pickupType != null &&
                              (controller.userData.value.isPickUpDriver ||
                                  controller.userData.value.isBothDriverType)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constant.appHorizontalPadding),
                              child: CheckInListButton(
                                isDesktop: screen.isDesktop,
                                color: const Color(0xff6ABE9D),
                                onPress: () => Get.toNamed(
                                    RouteName.checkInList,
                                    arguments: true),
                              ),
                            );
                          }
                          return const Offstage();
                        }),
                        Obx(() {
                          if (controller.userData.value.pickupType != null &&
                              (controller.userData.value.isPickUpDriver ||
                                  controller.userData.value.isBothDriverType)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constant.appHorizontalPadding),
                              child: CheckInListButton(
                                isDesktop: screen.isDesktop,
                                text: StringConstants.btnDeliveredToBronco,
                                onPress: () => Get.toNamed(
                                    RouteName.submitToOffice,
                                    arguments: true),
                              ),
                            );
                          }
                          return const Offstage();
                        }),
                        Obx(() {
                          if (controller.userData.value.pickupType != null &&
                              (controller.userData.value.isDeliveryDriver ||
                                  controller.userData.value.isBothDriverType)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constant.appHorizontalPadding),
                              child: DeliveryButton(
                                  isDesktop: screen.isDesktop,
                                  onPress: () => Get.toNamed(
                                      RouteName.checkInList,
                                      arguments: false)),
                            );
                          }
                          return const Offstage();
                        }),
                      ],
                    )
                  ],
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    if (controller.userData.value.pickupType != null &&
                        (controller.userData.value.isPickUpDriver ||
                            controller.userData.value.isBothDriverType)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constant.appHorizontalPadding),
                        child: CheckInListButton(
                          color: const Color(0xff6ABE9D),
                          onPress: () => Get.toNamed(RouteName.checkInList,
                              arguments: true),
                        ),
                      );
                    }
                    return const Offstage();
                  }),
                  Obx(() {
                    if (controller.userData.value.pickupType != null &&
                        (controller.userData.value.isPickUpDriver ||
                            controller.userData.value.isBothDriverType)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constant.appHorizontalPadding),
                        child: CheckInListButton(
                          text: StringConstants.btnDeliveredToBronco,
                          onPress: () => Get.toNamed(RouteName.submitToOffice,
                              arguments: true),
                        ),
                      );
                    }
                    return const Offstage();
                  }),
                  Obx(() {
                    if (controller.userData.value.pickupType != null &&
                        (controller.userData.value.isDeliveryDriver ||
                            controller.userData.value.isBothDriverType)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constant.appHorizontalPadding),
                        child: DeliveryButton(
                            onPress: () => Get.toNamed(RouteName.checkInList,
                                arguments: false)),
                      );
                    }
                    return const Offstage();
                  }),
                ],
              ),
      ),
    );
  }
}

class CheckInListButton extends StatelessWidget {
  final Function onPress;
  final String? text;
  final Color? color;
  final bool isDesktop;

  const CheckInListButton({
    required this.onPress,
    this.text,
    Key? key,
    this.color,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: () => onPress.call(),
      child: Container(
        width: isDesktop ? Get.width * 0.25 : double.infinity,
        height: isDesktop ? Get.width * 0.25 : Get.height * 0.25,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: color ?? AppTheme.of(context).primaryColor,
                blurRadius: 6.0,
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color ?? AppTheme.of(context).primaryColor,
                color ?? AppTheme.of(context).redColor,
              ],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(
            text ?? StringConstants.btnCheckInList,
            style: TextStyle(
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.OpenSans,
                fontSize: 70.sp,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class DeliveryButton extends StatelessWidget {
  final Function onPress;
  final bool isDesktop;

  const DeliveryButton(
      {required this.onPress, Key? key, this.isDesktop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      onTap: () => onPress.call(),
      child: Container(
        width: isDesktop ? Get.width * 0.25 : double.infinity,
        height: isDesktop ? Get.width * 0.25 : Get.height * 0.25,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(
            StringConstants.btnDelivered,
            style: TextStyle(
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.OpenSans,
                fontSize: 70.sp,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
