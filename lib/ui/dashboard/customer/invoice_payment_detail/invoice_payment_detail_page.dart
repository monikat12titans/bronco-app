import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'invoice_payment_detail_controller.dart';

class InvoicePaymentDetailPage
    extends GetResponsiveView<InvoicePaymentDetailController> {
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
                  headerTitle: StringConstants.labelInvoicePaymentDetail,
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
                        '${StringConstants.labelMAWB} #${invoiceData.mbn}',
                        style: TextStyle(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black87),
                      ),
                      Text(
                        '${StringConstants.labelInvoiceId} : ${invoiceData.invoiceId}',
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w800,
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
                        '${StringConstants.labelAmount}: \$${invoiceData.invoiceAmount}',
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black54),
                      ),
                      Text(
                        '${StringConstants.labelTax}: \$${invoiceData.taxAmount}',
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${StringConstants.labelTotalAmount}: \$${invoiceData.totalAmount}',
                        style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      if (screen.isDesktop)
                        Align(
                          alignment: Alignment.centerRight,
                          child: BroncoButton(
                            onPress: () => Get.toNamed(RouteName.paymentPage),
                            text: StringConstants.btnPayNow.toUpperCase(),
                            height: 100.h,
                            width: 120,
                            rounder: 30,
                          ),
                        )
                      else
                        BroncoButton(
                          onPress: () => Get.toNamed(RouteName.paymentPage),
                          text: StringConstants.btnPayNow.toUpperCase(),
                          height: 100.h,
                          width: Get.width * 0.9,
                          rounder: 5,
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
