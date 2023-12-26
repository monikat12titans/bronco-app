import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/billable_weight_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/common/widgets/cancel_button.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_billable_weight/billable_weigh/billable_weight_list_controller.dart';
import 'package:bronco_trucking/ui/dashboard/admin/admin_dashboard_page.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillableWeightListPage
    extends GetResponsiveView<BillableWeightListController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (screen.isDesktop)
              WebHeader(
                searchTextEditController: controller.searchTextEditController,
                hasSearch: true,
                headerTitle: StringConstants.labelBillableWeight,
                onSearchTextChange: controller.onSearchTextChanged,
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SearchBox(
                  isDesktop: screen.isDesktop,
                  textInputType: TextInputType.number,
                  hintText: StringConstants.hintSearchMAWBNumber,
                  onChange: controller.onSearchTextChanged,
                  textEditingController: controller.searchTextEditController,
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screen.isDesktop ? Constant.webPadding : 15),
                  child: Obx(() {
                  if (controller.isSuccess) {
                    return ScrollConfiguration(
                      behavior: const ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: AppTheme.of(Get.context!).primaryColor,
                        child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (_, index) {
                              var billableWeightData =
                                  controller.searchBillableWeightList[index];
                              return Obx(() => ExpansionPanelList(
                                    key: ValueKey(billableWeightData.id),
                                    expandedHeaderPadding: EdgeInsets.zero,
                                    elevation: 0,
                                    expansionCallback:
                                        (int eIndex, bool isExpanded) {
                                      controller.toExpandInvoiceItem(
                                          billableWeightData,
                                          hasExpand: isExpanded);
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
                                              '${StringConstants.labelMAWB} #${billableWeightData.mbnId}',
                                              style: TextStyle(
                                                  fontFamily: FontFamily.OpenSans,
                                                  color: Colors.black,
                                                  fontSize: 40.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          );
                                        },
                                        body: Obx(() => BillableWeightListItem(
                                              height: billableWeightData
                                                  .height.value,
                                              length: billableWeightData
                                                  .length.value,
                                              weight: billableWeightData
                                                  .weight.value,
                                              totalAmount:
                                                  billableWeightData.total,
                                              onAssignToDriver: () =>
                                                  Get.toNamed(
                                                      RouteName
                                                          .adminSelectDriver,
                                                      arguments: [
                                                    '${billableWeightData.mbnId}'
                                                  ]),
                                              onEditPress:() =>
                                                  openBottomSheet(
                                                      index, billableWeightData,
                                                      isDesktop:screen.isDesktop),

                                                  // _showBottomSheet(Get.context!)
                                            )),
                                        isExpanded:
                                            billableWeightData.isExpanded.value,
                                      ),
                                    ],
                                  ));
                            },
                            separatorBuilder: (_, index) {
                              return const Divider(
                                height: 2,
                              );
                            },
                            itemCount:
                                controller.searchBillableWeightList.length),
                      ),
                    );
                  }
                  if (controller.isSuccessWithEmptyList) {
                    return const EmptyListErrorText();
                  }
                  if (controller.isError) {
                    return ErrorText(
                      errorMessage: controller.statusMessage,
                    );
                  }
                  return const Offstage();
                }),
              ),
            ),          
          ],
        ),
      ),
    );
  }

 void openBottomSheet(int index, BillableWeightData billableWeightData,
      {bool isDesktop = true}) {
      controller.setBillWeight(
      billableWeightData.weight.value,
      billableWeightData.length.value,
      billableWeightData.height.value,
      billableWeightData.amount.value,
      billableWeightData.tax.value,
    );

    Get.bottomSheet( 
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:  Container(
          height: isDesktop ? 200 : 600,
          width: isDesktop ? Get.width * 0.95 : Get.width,
            //margin: EdgeInsets.only(left: isDesktop ? Get.width * 0.5 : 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
             padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                child: Container(
                  width: 120,
                  height: 5,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: FormField(
                  isDesktop: isDesktop,
                  billableWeightListController: controller,
                ),
              ),
              if (screen.isDesktop)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: BroncoButton(
                      width: 120,
                      rounder: 20,
                      onPress: () => controller.btnOnDoneTap(index),
                      text: StringConstants.btnDone.toUpperCase(),
                      hasGradientBg: false,
                    ),
                  ),
                ),
              if (!screen.isDesktop) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: BroncoButton(
                      rounder: 20,
                      onPress: () => controller.btnOnDoneTap(index),
                      text: StringConstants.btnDone.toUpperCase(),
                      hasGradientBg: false,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ])),
        ),
      
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        elevation: 10
        );
        
  }

//  void openBottomSheet(int index, BillableWeightData billableWeightData,
//     {bool isDesktop = true}) {
//     final screenWidth = MediaQuery.of(Get.context!).size.width;
//     final double desiredWidth = isDesktop ? screenWidth * 0.95 : screenWidth * 0.9;

//   Get.bottomSheet(
//     LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//        // Override maxWidth value
//         bool isDesktop = true;
//         maxWidth: Get.width;
//         constraints = BoxConstraints(maxWidth: Get.width, maxHeight: Get.height); // Set your desired maxWidth here
       
//         double containerWidth = constraints.maxWidth;
//         return 
//          SizedBox(
//           // Set explicit width here
//           width: containerWidth,
//           child: Stack(
//             children: [
//               // Background Container with Color
//                Expanded( 
//                 child:Container(
//                     color: Colors.blue, // Change color as needed
//                     height: double.infinity,
//               )),
//               // Your Content
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Expanded(
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Width: $containerWidth',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           SizedBox(height: 20),
//                           Text(
//                             'Testing Width',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
      
      
//         );
//       },
//     ),
//     isDismissible: false,
//   );
// }

// void _showBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//    context: context,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return SingleChildScrollView(
//         // Adjust constraints to remove padding
//         padding: EdgeInsets.zero,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.music_note),
//               title: Text('Music'),
//               onTap: () {
//                 // Handle music option
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo),
//               title: Text('Photos'),
//               onTap: () {
//                 // Handle photo option
//                 Navigator.pop(context);
//               },
//             ),
//             // Add more options as needed
//           ],
//         ),
//       );
//     },
//   );
// }


}

class FormField extends StatelessWidget {
  final bool isDesktop;
  final BillableWeightListController billableWeightListController;

  const FormField(
      {required this.isDesktop,
      required this.billableWeightListController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Row(
          children: [
            SizedBox(
              width: Get.width * 0.15,
              child: Row(
                children: [
                  Text(
                    StringConstants.labelWeight,
                    style: TextStyle(
                        fontFamily: FontFamily.OpenSans,
                        fontWeight: FontWeight.w600,
                        fontSize: 35.sp,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: BroncoTextFormField(
                    controller:
                        billableWeightListController.weightTextEditController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    suffixText: 'LBs',
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                  ))
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.15,
              child: Row(
                children: [
                  Text(
                    StringConstants.labelLength,
                    style: TextStyle(
                        fontFamily: FontFamily.OpenSans,
                        fontWeight: FontWeight.w600,
                        fontSize: 35.sp,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: BroncoTextFormField(
                    controller:
                        billableWeightListController.lengthTextEditController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    suffixText: 'in.',
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                  ))
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.15,
              child: Row(
                children: [
                  Text(
                    StringConstants.labelHeight,
                    style: TextStyle(
                        fontFamily: FontFamily.OpenSans,
                        fontWeight: FontWeight.w600,
                        fontSize: 35.sp,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: BroncoTextFormField(
                    controller:
                        billableWeightListController.heightTextEditController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    suffixText: 'in.',
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                  ))
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.15,
              child: Row(
                children: [
                  Text(
                    StringConstants.labelAmount,
                    style: TextStyle(
                        fontFamily: FontFamily.OpenSans,
                        fontWeight: FontWeight.w600,
                        fontSize: 35.sp,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: BroncoTextFormField(
                    controller:
                        billableWeightListController.amountTextEditController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    suffixText: '\$',
                    maxLength: 8,
                  ))
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: Get.width * 0.15,
              child: Row(
                children: [
                  Text(
                    StringConstants.labelTax,
                    style: TextStyle(
                        fontFamily: FontFamily.OpenSans,
                        fontWeight: FontWeight.w600,
                        fontSize: 35.sp,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: BroncoTextFormField(
                    controller:
                        billableWeightListController.taxTextEditController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    suffixText: '\$',
                    maxLength: 6,
                    inputFormatters: [
                      DecimalTextInputFormatter(decimalRange: 2)
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: Text(
                  StringConstants.labelWeight,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black),
                ),
              ),
              Expanded(
                  child: BroncoTextFormField(
                controller:
                    billableWeightListController.weightTextEditController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                suffixText: 'LBs',
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: Text(
                  StringConstants.labelLength,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black),
                ),
              ),
              Expanded(
                  child: BroncoTextFormField(
                controller:
                    billableWeightListController.lengthTextEditController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                suffixText: 'in.',
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: Text(
                  StringConstants.labelHeight,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black),
                ),
              ),
              Expanded(
                  child: BroncoTextFormField(
                controller:
                    billableWeightListController.heightTextEditController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                suffixText: 'in.',
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: Text(
                  StringConstants.labelAmount,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black),
                ),
              ),
              Expanded(
                  child: BroncoTextFormField(
                controller:
                    billableWeightListController.amountTextEditController,
                keyboardType: const TextInputType.numberWithOptions(),
                suffixText: '\$',
                maxLength: 8,
              ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.2,
                child: Text(
                  StringConstants.labelTax,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      fontWeight: FontWeight.w600,
                      fontSize: 35.sp,
                      color: Colors.black),
                ),
              ),
              Expanded(
                  child: BroncoTextFormField(
                controller: billableWeightListController.taxTextEditController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                suffixText: '\$',
                maxLength: 6,
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }
  }
}

class BillableWeightListItem extends StatelessWidget {
  final double? weight;
  final double? length;
  final double? height;
  final double? totalAmount;
  final Function? onEditPress;
  final Function? onAssignToDriver;

  const BillableWeightListItem({
    Key? key,
    this.weight,
    this.length,
    this.height,
    this.onEditPress,
    this.onAssignToDriver,
    this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TableItem(
          label: StringConstants.labelWeight,
          value: weight != 0.0 ? '$weight LBs' : null,
        ),
        const SizedBox(
          height: 10,
        ),
        _TableItem(
          label: StringConstants.labelLength,
          value: length != 0.0 ? '$length in.' : null,
        ),
        const SizedBox(
          height: 10,
        ),
        _TableItem(
          label: StringConstants.labelHeight,
          value: height != 0.0 ? '$height in.' : null,
        ),
        const SizedBox(
          height: 10,
        ),
        if (totalAmount != null && totalAmount != 0.0) ...[
          _TableItem(
            label: StringConstants.labelTotalAmount,
            value: '$totalAmount \$',
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CancelButton(
              onPress: () => onEditPress?.call(),
              height: 35,
              width: 70,
              blurRadius: 1.0,
              rounderCorner: 5,
              text: StringConstants.btnEdit,
            ),
            const SizedBox(
              width: 10,
            ),
            if (weight != 0.0 && length != 0.0 && height != 0.0)
              BroncoButton(
                //innerPadding: const EdgeInsets.symmetric(horizontal: 10),
                onPress: () => onAssignToDriver?.call(),
                height: 35,
                width: 160,
                blurRadius: 0.5,
                hasGradientBg: false,
                fontWeight: FontWeight.w500,
                text: StringConstants.btnAssignToDriver,
                rounder: 3,
              )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _TableItem extends StatelessWidget {
  final String label;
  final String? value;

  const _TableItem({required this.label, Key? key, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label : ',
          style: TextStyle(
              fontFamily: FontFamily.OpenSans,
              fontWeight: FontWeight.w600,
              fontSize: 35.sp,
              color: Colors.black),
        ),
        Text(
          value ?? ' - ',
          style: TextStyle(
              fontFamily: FontFamily.OpenSans,
              fontWeight: FontWeight.w600,
              fontSize: 35.sp,
              color: Colors.black54),
        )
      ],
    );
  }
}
