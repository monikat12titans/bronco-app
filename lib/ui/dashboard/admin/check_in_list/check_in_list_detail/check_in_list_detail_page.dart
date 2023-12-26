import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/check_in_list_detail/check_in_list_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckInListDetailPage
    extends GetResponsiveView<CheckInListDetailController> {
  @override
  Widget? builder() {
    var orderData = Get.arguments as OrderData;
    // var mbnId = argument['mbnId'];
    // var amount = argument['amount'];

    return Scaffold(
      body: BroncoAppBar(
          isDeskTop: screen.isDesktop,
          onBackTap: () => Get.back(),
          child: screen.isDesktop
              ? DesktopView(
                  orderData: orderData,
                )
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${StringConstants.labelMAWB} #${orderData.mbn}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 50.sp,
                          color: Colors.black,
                          fontFamily: FontFamily.OpenSans),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Weight(orderData: orderData),
                    const SizedBox(
                      height: 10,
                    ),
                    if (orderData.assignDriverName != null &&
                        orderData.assignDriverName!.isNotEmpty)
                      RichText(
                        text: TextSpan(
                          text: '${StringConstants.labelDriver} : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 35.sp,
                              color: Colors.black,
                              fontFamily: FontFamily.OpenSans),
                          children: <TextSpan>[
                            TextSpan(
                                text: orderData.assignDriverName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 35.sp,
                                    color: Colors.black87,
                                    fontFamily: FontFamily.OpenSans)),
                          ],
                        ),
                      ),
                    Payment(orderData: orderData),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${StringConstants.labelLastStatus} : ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 40.sp,
                              color: Colors.black87,
                              fontFamily: FontFamily.OpenSans),
                        ),
                        Flexible(
                          child: Text(
                            orderData.orderStatusInString,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 40.sp,
                                color: Colors.black54,
                                fontFamily: FontFamily.OpenSans),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BroncoButton(
                        onPress: () => Get.toNamed(RouteName.orderStatus,
                            arguments: {
                              Constant.argumentMBN: orderData.mbn ?? '0',
                              Constant.argumentIsForAdmin: true
                            }),
                        height: 35,
                        width: 90,
                        blurRadius: 0.5,
                        color: AppTheme.of(Get.context!)
                            .primaryColor
                            .withOpacity(0.8),
                        hasGradientBg: false,
                        fontWeight: FontWeight.w600,
                        text: StringConstants.btnTrack,
                        rounder: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(),
                    ...pickUpImage(orderData),
                    const Divider(),
                    ...deliveryImage(orderData),
                    const Divider(),
                  ],
                )),
    );
  }
}

class DesktopView extends StatelessWidget {
  final OrderData orderData;

  const DesktopView({
    required this.orderData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WebHeader(
          headerTitle: StringConstants.labelCheckInDetail,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Constant.webPadding, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${StringConstants.labelMAWB} #${orderData.mbn}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 60.sp,
                                color: Colors.black,
                                fontFamily: FontFamily.OpenSans),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Weight(orderData: orderData),
                          const SizedBox(
                            height: 10,
                          ),
                          if (orderData.assignDriverName != null &&
                              orderData.assignDriverName!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                text: '${StringConstants.labelDriver} : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35.sp,
                                    color: Colors.black,
                                    fontFamily: FontFamily.OpenSans),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: orderData.assignDriverName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 35.sp,
                                          color: Colors.black87,
                                          fontFamily: FontFamily.OpenSans)),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Payment(orderData: orderData),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${StringConstants.labelLastStatus} : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40.sp,
                                    color: Colors.black87,
                                    fontFamily: FontFamily.OpenSans),
                              ),
                              Flexible(
                                child: Text(
                                  orderData.orderStatusInString,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 40.sp,
                                      color: Colors.black54,
                                      fontFamily: FontFamily.OpenSans),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: BroncoButton(
                              onPress: () => Get.toNamed(RouteName.orderStatus,
                                  arguments: {
                                    Constant.argumentMBN: orderData.mbn ?? '0',
                                    Constant.argumentIsForAdmin: true
                                  }),
                              height: 35,
                              width: 90,
                              blurRadius: 0.5,
                              color: AppTheme.of(Get.context!)
                                  .primaryColor
                                  .withOpacity(0.8),
                              hasGradientBg: false,
                              fontWeight: FontWeight.w600,
                              text: StringConstants.btnTrack,
                              rounder: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: pickUpImage(orderData).sublist(0, 4),
                    ),
                  ),
                )),
                Expanded(
                    child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: pickUpImage(orderData).sublist(5, 9),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constant.webPadding, vertical: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: deliveryImage(orderData).sublist(0, 4),
                        ),
                      ),
                    )),
                Expanded(
                    child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: deliveryImage(orderData).sublist(5, 9),
                    ),
                  ),
                )),
                const Expanded(flex: 1, child: Offstage()),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Payment extends StatelessWidget {
  const Payment({
    required this.orderData,
    Key? key,
  }) : super(key: key);

  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              '${StringConstants.labelInvoicePaymentStatus} : ',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40.sp,
                  color: Colors.black,
                  fontFamily: FontFamily.OpenSans),
            ),
            Text(
              '${orderData.isPaid ? StringConstants.paid : StringConstants.notPaid} ',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40.sp,
                  color: Colors.black54,
                  fontFamily: FontFamily.OpenSans),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${StringConstants.labelTotalAmount} : ',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 40.sp,
                  color: Colors.black,
                  fontFamily: FontFamily.OpenSans),
            ),
            Text(
              '\$${orderData.totalAmount}(\$${orderData.invoiceAmount}+\$${orderData.taxAmount})',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40.sp,
                  color: Colors.black54,
                  fontFamily: FontFamily.OpenSans),
            ),
          ],
        )
      ],
    );
  }
}

class Weight extends StatelessWidget {
  const Weight({
    required this.orderData,
    Key? key,
  }) : super(key: key);

  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: '${StringConstants.labelWeight} : ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 35.sp,
                color: Colors.black,
                fontFamily: FontFamily.OpenSans),
            children: <TextSpan>[
              TextSpan(
                  text: orderData.weight,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 35.sp,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans)),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: '${StringConstants.labelHeight} : ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 35.sp,
                color: Colors.black,
                fontFamily: FontFamily.OpenSans),
            children: <TextSpan>[
              TextSpan(
                  text: orderData.height,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 35.sp,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans)),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RichText(
          text: TextSpan(
            text: '${StringConstants.labelLength} : ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 35.sp,
                color: Colors.black,
                fontFamily: FontFamily.OpenSans),
            children: <TextSpan>[
              TextSpan(
                  text: orderData.length,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 35.sp,
                      color: Colors.white54,
                      fontFamily: FontFamily.OpenSans)),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    required this.imagePath,
    this.isSignature = false,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final bool isSignature;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      child: imagePath.isEmpty
          ? Center(
              child: Text(
                StringConstants.errorNotAvailable,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 50.sp,
                    color: Colors.black54,
                    fontFamily: FontFamily.OpenSans),
              ),
            )
          : ColoredBox(
              color: isSignature ? const Color(0xffF5F5F5) : Colors.white,
              child: InkWell(
                onTap: () => Get.toNamed(RouteName.podPage,
                    arguments: isSignature
                        ? Utils.productSignaturePath(imagePath)
                        : Utils.productImagePath(imagePath)),
                child: Image.network(
                  isSignature
                      ? Utils.productSignaturePath(imagePath)
                      : Utils.productImagePath(imagePath),
                  fit: BoxFit.fill,
                  height: Get.height * 0.3,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
    );
  }
}

List<Widget> pickUpImage(OrderData orderData) {
  return [
    Text(
      StringConstants.labelPickUpDriverImage,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 50.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    Text(
      orderData.pickUpDriverProduct!.isNotEmpty
          ? orderData.pickupDriverImageDatetime ?? ''
          : '',
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 30.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    const SizedBox(
      height: 10,
    ),
    ImageLoader(imagePath: orderData.pickUpDriverProduct ?? ''),
    const SizedBox(
      height: 20,
    ),
    Text(
      StringConstants.labelPickUpDriverSignature,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 50.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    Text(
      orderData.pickUpDriverSignature!.isNotEmpty
          ? orderData.pickupDriverSignatureDatetime ?? ''
          : '',
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 30.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    const SizedBox(
      height: 10,
    ),
    ImageLoader(
      imagePath: orderData.pickUpDriverSignature ?? '',
      isSignature: true,
    )
  ];
}

List<Widget> deliveryImage(OrderData orderData) {
  return [
    Text(
      StringConstants.labelDeliveryDriverImage,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 50.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    Text(
      orderData.deliveryDriverProduct!.isNotEmpty
          ? orderData.deliveryDriverImageDatetime ?? ''
          : '',
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 30.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    const SizedBox(
      height: 10,
    ),
    ImageLoader(imagePath: orderData.deliveryDriverProduct ?? ''),
    const SizedBox(
      height: 20,
    ),
    Text(
      StringConstants.labelDeliveryDriverSignature,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 50.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    Text(
      orderData.deliveryDriverSignature!.isNotEmpty
          ? orderData.deliveryDriverSignatureDatetime ?? ''
          : '',
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 30.sp,
          color: Colors.black,
          fontFamily: FontFamily.OpenSans),
    ),
    const SizedBox(
      height: 10,
    ),
    ImageLoader(
      imagePath: orderData.deliveryDriverSignature ?? '',
      isSignature: true,
    )
  ];
}
