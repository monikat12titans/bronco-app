import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/customer/select_mawb_payment/select_mawb_payment_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMAWBPaymentPage extends GetView<SelectMAWBPaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BroncoAppBar(
        onBackTap: () => Get.back(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                StringConstants.labelSelectMAWB,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 70.sp,
                    letterSpacing: 1.5,
                    color: Colors.black54,
                    fontFamily: FontFamily.OpenSans),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SearchBox(
                textEditingController: controller.searchTextEditController,
                onChange: controller.onSearchTextChanged,
                hintText: StringConstants.hintSearchMAWBNumber,
                textInputType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(() {
                if (controller.isSuccess) {
                  return ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: AppTheme.of(context).primaryColor,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        itemBuilder: (_, index) {
                          var data = controller.searchOrderList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () => controller.onRadioTap(data),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => BroncoRadio(
                                        isSelected: data.isSelected.value),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${StringConstants.labelMAWB} #${data.mbn}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 40.sp,
                                            color: Colors.black87,
                                            fontFamily: FontFamily.OpenSans),
                                      ),
                                      Text(
                                        '${StringConstants.labelInvoiceId} : ${data.invoiceId}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.sp,
                                            color: Colors.black87,
                                            fontFamily: FontFamily.OpenSans),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${StringConstants.labelTotalAmount} : ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 35.sp,
                                              color: Colors.black,
                                              fontFamily: FontFamily.OpenSans),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' \$${data.totalAmount}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 35.sp,
                                                    color: Colors.black54,
                                                    fontFamily:
                                                        FontFamily.OpenSans)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const Divider(
                            height: 2,
                          );
                        },
                        itemCount: controller.searchOrderList.length,
                      ),
                    ),
                  );
                }
                if (controller.isSuccessWithEmptyList) {
                  return const EmptyListErrorText();
                }
                if (controller.isError) {
                  return ErrorText(
                    errorMessage: controller.error,
                  );
                }
                return const Offstage();
              }),
            ),
            Obx(() {
              if (controller.isSuccess) {
                return BroncoButton(
                  onPress: () => controller.onSubmitTap(),
                  text: StringConstants.btnPayNow.toUpperCase(),
                  hasGradientBg: false,
                  blurRadius: 0,
                  rounder: 0,
                );
              }
              return const Offstage();
            })
          ],
        ),
      ),
    );
  }
}
