import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_controller.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/invoice_list_item.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/outstanding_invoice_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoicesTab extends StatelessWidget {
  final bool isDesktop;

  const InvoicesTab({Key? key, this.isDesktop = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerDashboardController controller =
        Get.find<CustomerDashboardController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: isDesktop
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(SVGPath.star),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              StringConstants.labelOutstandingInvoices
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontFamily: FontFamily.OpenSans,
                                  color: const Color(0xff536172),
                                  fontSize: 40.sp,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            padding: const EdgeInsets.only(right: 25),
                            itemBuilder: (_, index) {
                              return OutstandingInvoiceListItem(
                                index: index,
                                invoiceData:
                                    controller.outstandingInvoiceList[index],
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                height: 2,
                                color: Colors.black26,
                              );
                            },
                            itemCount:
                                controller.outstandingInvoiceList.length),
                      )
                    ],
                  )),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(SVGPath.star),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                StringConstants.labelInvoices.toUpperCase(),
                                style: TextStyle(
                                    fontFamily: FontFamily.OpenSans,
                                    color: const Color(0xff536172),
                                    fontSize: 40.sp,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              padding: const EdgeInsets.only(left: 20,top: 10),
                              itemBuilder: (_, index) {
                                var invoicedData =
                                    controller.invoicedList[index];
                                return Obx(() => ExpansionPanelList(
                                      key: ValueKey(invoicedData.id),
                                      expandedHeaderPadding: EdgeInsets.zero,
                                      elevation: 0,
                                      expansionCallback:
                                          (int eIndex, bool isExpanded) {
                                        controller.toExpandInvoiceItem(index,
                                            hasExpand: !isExpanded);
                                      },
                                      children: [
                                        ExpansionPanel(
                                          canTapOnHeader: true,
                                          headerBuilder:
                                              (BuildContext context,
                                                  bool isExpanded) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      SVGPath.star),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${StringConstants.labelInvoiceId.toUpperCase()} ${invoicedData.invoiceId}',
                                                    style: TextStyle(
                                                        fontFamily: FontFamily
                                                            .OpenSans,
                                                        color: const Color(
                                                            0xff536172),
                                                        fontSize: 40.sp,
                                                        letterSpacing: 1.2,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          body: InvoiceListItem(
                                            invoiceData: invoicedData,
                                            onPayNowTap: () {
                                              Get.toNamed(
                                                  RouteName
                                                      .invoicePaymentDetail,
                                                  arguments: invoicedData);
                                            },
                                            onSeePODImageTap: (image) {
                                              Get.toNamed(RouteName.podPage,
                                                  arguments: image);
                                            },
                                            onTap: (data) {
                                              Get.toNamed(
                                                  RouteName.invoiceDetail,
                                                  arguments: data);
                                            },
                                          ),
                                          isExpanded:
                                              invoicedData.isExpanded.value,
                                        ),
                                      ],
                                    ));
                              },
                              separatorBuilder: (_, index) {
                                var invoicedData =
                                    controller.invoicedList[index];
                                return Obx(() => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              invoicedData.isExpanded.value
                                                  ? 20
                                                  : 0),
                                      child: Divider(
                                        height: 2,
                                        color: invoicedData.isExpanded.value
                                            ? AppTheme.of(context)
                                                .primaryColor
                                            : Colors.black12,
                                        thickness:
                                            invoicedData.isExpanded.value
                                                ? 10
                                                : 0,
                                      ),
                                    ));
                              },
                              itemCount: controller.invoicedList.length),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: AppTheme.of(context).primaryColor,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 70),
                  children: [
                    Obx(
                      () => ExpansionPanelList(
                        expandedHeaderPadding: EdgeInsets.zero,
                        elevation: 0,
                        expansionCallback: (int eIndex, bool isExpanded) {
                          controller.toExpandOutstandInvoice(
                              hasExpand: !isExpanded);
                        },
                        children: [
                          ExpansionPanel(
                            canTapOnHeader: true,
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(SVGPath.star),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      StringConstants.labelOutstandingInvoices
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: FontFamily.OpenSans,
                                          color: const Color(0xff536172),
                                          fontSize: 40.sp,
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              );
                            },
                            body: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  return OutstandingInvoiceListItem(
                                    index: index,
                                    invoiceData: controller
                                        .outstandingInvoiceList[index],
                                  );
                                },
                                separatorBuilder: (_, index) {
                                  return const Divider(
                                    height: 2,
                                    color: Colors.black26,
                                  );
                                },
                                itemCount:
                                    controller.outstandingInvoiceList.length),
                            isExpanded:
                                controller.isExpandedOutStandingInvoices.value,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          var invoicedData = controller.invoicedList[index];
                          return Obx(() => ExpansionPanelList(
                                key: ValueKey(invoicedData.id),
                                expandedHeaderPadding: EdgeInsets.zero,
                                elevation: 0,
                                expansionCallback:
                                    (int eIndex, bool isExpanded) {
                                  controller.toExpandInvoiceItem(index,
                                      hasExpand: !isExpanded);
                                },
                                children: [
                                  ExpansionPanel(
                                    canTapOnHeader: true,
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(SVGPath.star),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${StringConstants.labelInvoiceId.toUpperCase()} ${invoicedData.invoiceId}',
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontFamily.OpenSans,
                                                  color:
                                                      const Color(0xff536172),
                                                  fontSize: 40.sp,
                                                  letterSpacing: 1.2,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    body: InvoiceListItem(
                                      invoiceData: invoicedData,
                                      onPayNowTap: () {
                                        Get.toNamed(
                                            RouteName.invoicePaymentDetail,
                                            arguments: invoicedData);
                                      },
                                      onSeePODImageTap: (image) {
                                        Get.toNamed(RouteName.podPage,
                                            arguments: image);
                                      },
                                      onTap: (data) {
                                        Get.toNamed(RouteName.invoiceDetail,
                                            arguments: data);
                                      },
                                    ),
                                    isExpanded: invoicedData.isExpanded.value,
                                  ),
                                ],
                              ));
                        },
                        separatorBuilder: (_, index) {
                          var invoicedData = controller.invoicedList[index];
                          return Obx(() => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        invoicedData.isExpanded.value ? 20 : 0),
                                child: Divider(
                                  height: 2,
                                  color: invoicedData.isExpanded.value
                                      ? AppTheme.of(context).primaryColor
                                      : Colors.black12,
                                  thickness:
                                      invoicedData.isExpanded.value ? 10 : 0,
                                ),
                              ));
                        },
                        itemCount: controller.invoicedList.length)
                  ],
                ),
              ),
            ),
    );
  }
}
