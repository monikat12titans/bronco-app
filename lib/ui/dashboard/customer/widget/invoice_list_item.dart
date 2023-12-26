import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/models/invoice_data.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:flutter/material.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoiceListItem extends StatelessWidget {
  final OrderData invoiceData;
  final Function? onPayNowTap;
  final Function(String)? onSeePODImageTap;
  final Function(OrderData)? onTap;

  const InvoiceListItem({
    required this.invoiceData,
    Key? key,
    this.onPayNowTap,
    this.onSeePODImageTap,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: InkWell(
        onTap: () => onTap?.call(invoiceData),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${StringConstants.labelInvoiceId.toUpperCase()} ${invoiceData.invoiceId}',
                  style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.9,
                      fontFamily: FontFamily.OpenSans,
                      color: invoiceData.orderId >= 4
                          ? const Color(0xff6ABE9D)
                          : AppTheme.of(context).primaryColor),
                ),
                const Spacer(),
                Text(
                  '${StringConstants.labelMAWB} #${invoiceData.mbn}',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.OpenSans,
                      letterSpacing: 0.25,
                      color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  SVGPath.truckIc,
                  width: 8,
                  height: 8,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${StringConstants.labelDeliveryStatus.toUpperCase()} - ',
                  style: TextStyle(
                      fontSize: 26.sp,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.OpenSans,
                      color: const Color(0xff4E4E4E)),
                ),
                Text(
                  (invoiceData.statusText ?? '').toUpperCase(),
                  style: TextStyle(
                      fontSize: 26.sp,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.OpenSans,
                      color: invoiceData.orderId >= 4
                          ? const Color(0xff6ABE9D)
                          : AppTheme.of(context).primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                Text(
                  invoiceData.deliverdDatetime ?? '',
                  style: TextStyle(
                      fontSize: 25.sp,
                      letterSpacing: 0.22,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.OpenSans,
                      color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  SVGPath.invoiceIc,
                  width: 8,
                  height: 8,
                ),
                const SizedBox(
                  width: 14,
                ),
                Text(
                  StringConstants.labelInvoicePaymentStatus.toUpperCase(),
                  style: TextStyle(
                      fontSize: 26.sp,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamily.OpenSans,
                      color: const Color(0xff4E4E4E)),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 21,
                ),
                Text(
                  invoiceData.isPaid
                      ? StringConstants.paid.toUpperCase()
                      : invoiceData.paymentDate ?? '',
                  style: TextStyle(
                      fontSize: 25.sp,
                      letterSpacing: 0.22,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.OpenSans,
                      color: Colors.black54),
                ),
              ],
            ),
            if (!invoiceData.isPaid) ...[
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: BroncoButton(
                  onPress: () => onPayNowTap?.call(),
                  text: StringConstants.btnNotPaid,
                  height: 60.h,
                  width: 250.w,
                  fontWeight: FontWeight.w500,
                  rounder: 30,
                  hasGradientBg: false,
                  textSize: 30.sp,
                  blurRadius: 0,
                ),
              )
            ],
            /* if (invoiceData.deliveryStatus ==
                DeliveryStatus.delivered.index) ...[
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: BroncoButton(
                  height: 60.h,
                  width: 290.w,
                  rounder: 30,
                  textSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  hasGradientBg: false,
                  blurRadius: 0,
                  color: const Color(0xff6ABE9D),
                  onPress: () => onSeePODImageTap?.call(invoiceData.podImg),
                  text: StringConstants.btnSeePODImage,
                ),
              )
            ]*/
          ],
        ),
      ),
    );
  }
}
