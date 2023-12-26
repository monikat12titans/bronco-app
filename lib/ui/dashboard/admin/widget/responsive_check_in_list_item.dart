import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/substring_highlight.dart';
import 'package:flutter/material.dart';

class ResponsiveCheckInListItem extends StatelessWidget {
  final OrderData orderData;
  final Function? onTap;
  final bool isHighlightedMBN;
  final String highlightedText;
  final bool isDesktop;

  const ResponsiveCheckInListItem({
    required this.orderData,
    Key? key,
    this.onTap,
    this.isHighlightedMBN = false,
    this.highlightedText = '',
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      onTap: () => onTap?.call(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: isDesktop
            ? Row(
                children: [
                  if (isHighlightedMBN) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${StringConstants.labelHouseNumber} #',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 40.sp,
                              color: Colors.black,
                              fontFamily: FontFamily.OpenSans),
                        ),
                        SubstringHighlight(
                          text: orderData.houseNumber.toString() != '0'
                              ? orderData.houseNumber ?? '-'
                              : '-',
                          term: highlightedText,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 40.sp,
                              color: Colors.black,
                              fontFamily: FontFamily.OpenSans),
                          textStyleHighlight: TextStyle(
                              color: AppTheme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ] else
                    Expanded(
                      child: Text(
                        orderData.houseNumber.toString() != '0'
                            ? orderData.houseNumber ?? '-'
                            : '-',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 40.sp,
                            color: Colors.black,
                            fontFamily: FontFamily.OpenSans),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      '${orderData.mbn}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35.sp,
                          color: Colors.black54,
                          fontFamily: FontFamily.OpenSans),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      orderData.orderStatusInString,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35.sp,
                          color: Colors.black54,
                          fontFamily: FontFamily.OpenSans),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${orderData.deliverdDatetime}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35.sp,
                          color: Colors.black87,
                          fontFamily: FontFamily.OpenSans),
                    ),
                  ),
                  Expanded(
                    child: ResponseWeightHeightLength(
                      orderData: orderData,
                      isDesktop: true,
                    ),
                  ),
                  Expanded(
                    child: Text(
                        '${(orderData.assignDriverName != null && orderData.assignDriverName!.isNotEmpty) ? orderData.assignDriverName : '-'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
                            fontFamily: FontFamily.OpenSans)),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isHighlightedMBN) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${StringConstants.labelHouseNumber} ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 40.sp,
                              color: Colors.black54,
                              fontFamily: FontFamily.OpenSans),
                        ),
                        SubstringHighlight(
                          text: orderData.houseNumber ?? '',
                          term: highlightedText,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 40.sp,
                              color: Colors.black54,
                              fontFamily: FontFamily.OpenSans),
                          textStyleHighlight: TextStyle(
                              color: AppTheme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ] else ...{
                    if (orderData.houseNumber.toString() != '0') ...{
                      Text(
                        '${StringConstants.labelHouseNumber} #${orderData.houseNumber}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 40.sp,
                            color: Colors.black54,
                            fontFamily: FontFamily.OpenSans),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    }
                  },
                  Text(
                    '${StringConstants.labelMAWB} #${orderData.mbn}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                        color: Colors.black54,
                        fontFamily: FontFamily.OpenSans),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${StringConstants.labelCheckIn}: ${orderData.orderStatusInString}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 45.sp,
                        color: Colors.black87,
                        fontFamily: FontFamily.OpenSans),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    '${StringConstants.labelTime}: ${orderData.deliverdDatetime}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 35.sp,
                        color: Colors.black87,
                        fontFamily: FontFamily.OpenSans),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ResponseWeightHeightLength(orderData: orderData),
                  const SizedBox(
                    height: 1,
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
                ],
              ),
      ),
    );
  }
}

class ResponseWeightHeightLength extends StatelessWidget {
  const ResponseWeightHeightLength({
    Key? key,
    required this.orderData,
    this.isDesktop = false,
  }) : super(key: key);

  final OrderData orderData;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '${StringConstants.labelWeight} : ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '${orderData.weight} ${orderData.weight!.isEmpty ? '' : 'LBs'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
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
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '${orderData.height} ${orderData.height!.isEmpty ? '' : 'in.'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
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
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '${orderData.length} ${orderData.length!.isEmpty ? '' : 'in.'}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
                            fontFamily: FontFamily.OpenSans)),
                  ],
                ),
              ),
            ],
          )
        : Row(
            children: [
              RichText(
                text: TextSpan(
                  text: '${StringConstants.labelWeight} : ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                  children: <TextSpan>[
                    TextSpan(
                        text: orderData.weight,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
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
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                  children: <TextSpan>[
                    TextSpan(
                        text: orderData.height,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
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
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                  children: <TextSpan>[
                    TextSpan(
                        text: orderData.length,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 35.sp,
                            color: Colors.black87,
                            fontFamily: FontFamily.OpenSans)),
                  ],
                ),
              ),
            ],
          );
  }
}
