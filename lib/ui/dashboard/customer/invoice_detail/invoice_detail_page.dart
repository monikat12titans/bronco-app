import 'package:bronco_trucking/models/invoice_data.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/payment/payment_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bronco_trucking/di/app_core.dart';

class InvoiceDetailPage extends GetResponsiveView<PaymentController> {
  @override
  Widget? builder() {
    var invoiceData = Get.arguments as OrderData;

    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              if (screen.isDesktop)
                const WebHeader(
                  headerTitle: StringConstants.labelInvoiceDetail,
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screen.isDesktop ? Constant.webPadding : 20,
                      vertical: screen.isDesktop ? 20 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${StringConstants.labelInvoiceId} ${invoiceData.invoiceId}',
                        style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black87),
                      ),
                      Text(
                        '${StringConstants.labelMAWB} #${invoiceData.mbn}',
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        StringConstants.labelDeliveryStatus,
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black87),
                      ),
                      Text(
                        '${invoiceData.statusText} ${invoiceData.deliverdDatetime}',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        StringConstants.labelInvoicePaymentStatus,
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black87),
                      ),
                      Text(
                        invoiceData.isPaid
                            ? StringConstants.paid
                            : StringConstants.notPaid,
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black54),
                      ),
                      const Spacer(),
                      if (!invoiceData.isPaid) ...[
                        const SizedBox(
                          height: 10,
                        ),
                        if (screen.isDesktop)
                          Align(
                            alignment: Alignment.centerRight,
                            child: BroncoButton(
                              onPress: () => Get.toNamed(
                                  RouteName.invoicePaymentDetail,
                                  arguments: invoiceData),
                              text: StringConstants.btnPayNow.toUpperCase(),
                              height: 100.h,
                              width: 120,
                              rounder: 30,
                            ),
                          )
                        else
                          Center(
                            child: BroncoButton(
                              onPress: () => Get.toNamed(
                                  RouteName.invoicePaymentDetail,
                                  arguments: invoiceData),
                              text: StringConstants.btnPayNow.toUpperCase(),
                              height: 100.h,
                              width: Get.width * 0.9,
                              rounder: 5,
                            ),
                          )
                      ],
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              )
              /*if (invoiceData.deliveryStatus ==
                  DeliveryStatus.delivered.index)
                Align(
                  child: InkWell(
                      onTap: () => Get.toNamed(RouteName.podPage,
                          arguments: invoiceData.podImg),
                      child: Image.network(
                        invoiceData.podImg,
                        fit: BoxFit.contain,
                        width: Get.width - 100,
                      )),
                )*/
            ],
          ),
        ),
      ),
    );
  }
}
