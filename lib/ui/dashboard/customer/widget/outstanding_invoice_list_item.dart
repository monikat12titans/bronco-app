import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/outstanding_invoice_data.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OutstandingInvoiceListItem extends StatelessWidget {
  final OrderData invoiceData;
  final int index;

  const OutstandingInvoiceListItem(
      {required this.invoiceData, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerDashboardController controller =
        Get.find<CustomerDashboardController>();
    return InkWell(
      onTap: () => controller.onRadioTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Obx(
              () => BroncoRadio(isSelected: invoiceData.isSelected.value),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${StringConstants.labelInvoiceId} ${invoiceData.invoiceId}',
              style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.OpenSans,
                  color: Colors.black54),
            ),
            const Spacer(),
            InkWell(
              onTap: () => controller.onOpenOutstandingInvoiceTap(invoiceData),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  SVGPath.openIc,
                  height: 12,
                  width: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
