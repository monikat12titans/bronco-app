import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/message_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_send_message_text_field.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/message_list_item.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/message_submit.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_message_controller.dart';

class AdminMessagePage extends GetResponsiveView<AdminMessageController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Obx(() {
          if (controller.isSuccess || controller.isSuccessWithEmptyList) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (screen.isDesktop)
                  const WebHeader(
                    headerTitle: StringConstants.labelMessages,
                  ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: AppTheme.of(Get.context!).primaryColor,
                      child: ListView.separated(
                          controller: controller.messageScrollController,
                          padding: EdgeInsets.only(
                              bottom: 30,
                              left: screen.isDesktop ? Constant.webPadding : 20,
                              right:
                                  screen.isDesktop ? Constant.webPadding : 20),
                          itemBuilder: (_, index) {
                            var data = controller.messages.value[index];
                            return MessageListItem(
                              isFromAdmin: true,
                              hasReplyLabel: data.replyId == '0',
                              loginId: controller.userData!.userid ?? '0',
                              messageData: data,
                              onReplyTap: () =>
                                  openReplyDialog(data, controller),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const Divider(
                              height: 2,
                            );
                          },
                          itemCount: controller.messages.value.length),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Obx(() => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screen.isDesktop ? Constant.webPadding : 15),
                        child: CustomerSelection(
                          onTap: controller.onSelectCustomerTap,
                          customerName: controller.customerName.value,
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screen.isDesktop ? Constant.webPadding : 15,vertical: 10),
                  child: BroncoSendMessageTextFormField(
                    controller: controller.messageTextEditController,
                    submitIcon: InkWell(
                      onTap: controller.onMessageSentTap,
                      child: const MessageSubmit(),
                    ),
                  ),
                )
              ],
            );
          }

          if (controller.isError) {
            return ErrorText(
              errorMessage: controller.statusMessage,
            );
          }
          return const Offstage();
        }),
      ),
    );
  }
}

class CustomerSelection extends StatelessWidget {
  final String customerName;
  final Function()? onTap;

  const CustomerSelection({required this.customerName, Key? key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            StringConstants.labelSelectCustomer,
            style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.OpenSans,
                color: Colors.black87),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: Get.width * 0.5,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  customerName.isEmpty
                      ? StringConstants.labelSelectCustomer
                      : customerName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontFamily.OpenSans,
                      color: customerName.isEmpty
                          ? Colors.black54
                          : Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

openReplyDialog(
    MessageData messageData, AdminMessageController adminMessageController) {
  Get.defaultDialog(
      title: 'To : ${messageData.clientName ?? ''}',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BroncoTextFormField(
            hintText: StringConstants.hintEnterMessage,
            controller: adminMessageController.replyTextEditController,
          ),
          const SizedBox(
            height: 30.0,
          ),
          BroncoButton(
            onPress: () => adminMessageController
                .onReplySentTap(messageData.customerId ?? ''),
            text: StringConstants.labelReply.toUpperCase(),
          )
        ],
      ),
      radius: 10.0);
}
