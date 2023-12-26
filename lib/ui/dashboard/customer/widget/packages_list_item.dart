import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/package_data.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/date_time_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackagesListItem extends StatelessWidget {
  final OrderData orderData;
  final Function() onTap;

  const PackagesListItem({
    required this.orderData,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffC1C1C1).withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '${StringConstants.labelShipment.toUpperCase()} #',
                    style: TextStyle(
                        fontSize: 45.sp,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w800,
                        fontFamily: FontFamily.OpenSans,
                        color: Colors.black87),
                    children: <TextSpan>[
                      TextSpan(
                          text: orderData.mbn,
                          style: TextStyle(
                              fontSize: 45.sp,
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
                      : AppTheme.of(context).primaryColor,
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
                            : AppTheme.of(context).primaryColor),
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
            /* if (packageData.isDelivered) ...[
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: SizedBox(
                      height: 8,
                      width: 8,
                      child: ColoredBox(color: Color(0xffc1c1c1)),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: Text(
                      '${StringConstants.labelPackage} ${StringConstants.labelDeliveredTo} ${packageData.deliveredAddress}',
                      style: TextStyle(
                          fontSize: 35.sp,
                          height: 1.3,
                          letterSpacing: 0.25,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.Interstate,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(
              height: 5,
            ),
            if (packageData.isDelivered && packageData.deliveredTime != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 13,
                    width: 20,
                  ),
                  DateTimeLabel(dateTime: packageData.deliveredTime!),
                ],
              ),
            if (packageData.isInvoiceSent) ...[
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: SizedBox(
                      height: 8,
                      width: 8,
                      child: ColoredBox(color: Color(0xffc1c1c1)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringConstants.labelInvoiceSent,
                          style: TextStyle(
                              fontSize: 35.sp,
                              height: 1,
                              letterSpacing: 0.25,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.Interstate,
                              color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        DateTimeLabel(dateTime: packageData.paymentTime!)
                      ],
                    ),
                  ),
                  // const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: packageData.paymentStatus == 1
                            ? Colors.black12
                            : AppTheme.of(context).primaryColor.withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      '${StringConstants.labelPayment} ${packageData.paymentStatus == 1 ? StringConstants.labelPending : StringConstants.labelComplete}',
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.25,
                          fontFamily: FontFamily.Interstate,
                          color: packageData.paymentStatus == 1
                              ? Colors.black54
                              : Colors.white),
                    ),
                  ),
                ],
              ),
            ]*/
          ],
        ),
      ),
    );
  }
}
