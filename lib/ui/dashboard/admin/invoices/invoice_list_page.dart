import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/invoice_data.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'invoice_list_controller.dart';

class InvoiceListPage extends GetView<InvoiceListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BroncoAppBar(
        onBackTap: () => Get.back(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SearchBox(),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => controller.onSelectLabelTap(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() => Text(
                        controller.isSelectedAll.isTrue
                            ? StringConstants.labelUnselectAll
                            : StringConstants.labelSelectAll,
                        style: TextStyle(
                            fontFamily: FontFamily.OpenSans,
                            color: Colors.black,
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                    itemBuilder: (_, index) {
                      var invoicedData = controller.invoicedList[index];
                      return Obx(() => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 5),
                                child: InkWell(
                                  onTap: () => controller.onRadioTap(
                                      index, !invoicedData.isSelected.value),
                                  child: BroncoRadio(
                                    isSelected: invoicedData.isSelected.value,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ExpansionPanelList(
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
                                          child: Text(
                                            '${StringConstants.labelInvoiceId} ${invoicedData.invoiceId}',
                                            style: TextStyle(
                                                fontFamily: FontFamily.OpenSans,
                                                color: Colors.black,
                                                fontSize: 40.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        );
                                      },
                                      body: InvoiceListItem(
                                        invoiceData:
                                            controller.invoicedList[index],
                                        onPODTap: () => Get.toNamed(
                                            RouteName.podPage,
                                            arguments: controller
                                                .invoicedList[index].podImg),
                                      ),
                                      isExpanded: invoicedData.isExpanded.value,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                    },
                    separatorBuilder: (_, index) {
                      return const Divider(
                        height: 2,
                      );
                    },
                    itemCount: controller.invoicedList.length),
              ),
            ),
            BroncoButton(
              onPress: () => controller.btnSentTap(),
              rounder: 0,
              text: StringConstants.btnSendSelectedInvoices,
            )
          ],
        ),
      ),
    );
  }
}

class InvoiceListItem extends StatelessWidget {
  final InvoiceData invoiceData;
  final Function onPODTap;

  const InvoiceListItem(
      {required this.invoiceData, required this.onPODTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${StringConstants.labelMAWB} ${invoiceData.mdnId}',
            style: TextStyle(
                fontFamily: FontFamily.OpenSans,
                color: Colors.black,
                fontSize: 40.sp,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '${StringConstants.labelDelivered} : ${Utils.getDateFromTimestamp(invoiceData.deliveryStatusTime)}',
            style: TextStyle(
                fontFamily: FontFamily.OpenSans,
                color: Colors.black,
                fontSize: 38.sp,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '${StringConstants.to} ${invoiceData.address}',
            style: TextStyle(
                fontFamily: FontFamily.OpenSans,
                color: Colors.black87,
                fontSize: 38.sp,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          BroncoButton(
            onPress: () => onPODTap.call(),
            text: StringConstants.btnSeePODImage,
            height: 90.h,
            width: 390.w,
            rounder: 2,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
