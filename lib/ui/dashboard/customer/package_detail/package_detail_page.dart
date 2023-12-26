import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/customer/package_detail/package_detail_controller.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/date_time_label.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PackageDetailPage extends GetResponsiveView<PackageDetailController> {
  @override
  Widget? builder() {
    OrderData orderData = Get.arguments as OrderData;
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: screen.isDesktop
            ? Column(
                children: [
                  const WebHeader(
                    headerTitle: StringConstants.labelShipmentDetail,
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: DetailSection(orderData: orderData),
                      ),
                    ),
                  )
                ],
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: DetailSection(orderData: orderData),
              ),
      ),
    );
  }
}

class DetailSection extends StatelessWidget {
  const DetailSection({
    Key? key,
    required this.orderData,
  }) : super(key: key);

  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: '${StringConstants.labelShipment.toUpperCase()} #',
                style: TextStyle(
                    fontSize: 55.sp,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                    fontFamily: FontFamily.OpenSans,
                    color: Colors.black87),
                children: <TextSpan>[
                  TextSpan(
                      text: orderData.mbn,
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: FontFamily.OpenSans,
                          color: Colors.black87)),
                ],
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              SVGPath.star,
              height: 15,
              width: 15,
              color: orderData.isCheckedIn
                  ? const Color(0xff6ABE9D)
                  : AppTheme.of(Get.context!).primaryColor,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SvgPicture.asset(
              orderData.isCheckedIn ? SVGPath.rightIc : SVGPath.crossIc,
              height: 10,
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                '${StringConstants.labelShipment.toUpperCase()} ${(orderData.statusText ?? '').toUpperCase()}',
                style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                    fontFamily: FontFamily.OpenSans,
                    color: int.parse(orderData.orderStatus ?? '0') >= 2
                        ? const Color(0xff6ABE9D)
                        : AppTheme.of(Get.context!).primaryColor),
              ),
            ),
          ],
        ),
        if (orderData.isCheckedIn) ...[
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 13,
                width: 20,
              ),
              DateTimeLabel(dateTime: orderData.deliverdDatetime ?? ''),
            ],
          ),
        ],
        const SizedBox(
          height: 10,
        ),
        if ((orderData.pickUpDriverProduct ?? '').isNotEmpty) ...[
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteName.podPage,
                arguments: Utils.productImagePath(
                    orderData.pickUpDriverProduct ?? '')),
            child: Image.network(
              Utils.productImagePath(orderData.pickUpDriverProduct ?? ''),
              fit: BoxFit.fill,
              height: Get.height * 0.3 - 50,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: Get.height * 0.3 - 50,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
        if (!orderData.isDeliveryToCustomer)
          Align(
            alignment: Alignment.centerRight,
            child: BroncoButton(
              onPress: () => Get.toNamed(RouteName.orderStatus, arguments: {
                Constant.argumentMBN: orderData.mbn ?? '0',
                Constant.argumentIsForAdmin: false
              }),
              height: 35,
              width: 90,
              blurRadius: 0.5,
              color: AppTheme.of(Get.context!).primaryColor.withOpacity(0.8),
              hasGradientBg: false,
              fontWeight: FontWeight.w600,
              text: StringConstants.btnTrack,
              rounder: 20,
            ),
          ),
      ],
    );
  }
}
