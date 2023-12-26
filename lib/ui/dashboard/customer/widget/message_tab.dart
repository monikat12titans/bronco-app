import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_send_message_text_field.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_controller.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/message_list_item.dart';
import 'package:bronco_trucking/ui/dashboard/customer/widget/message_submit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageTab extends StatelessWidget {
  const MessageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomerDashboardController controller =
        Get.find<CustomerDashboardController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: AppTheme.of(context).primaryColor,
                child: ListView.separated(
                    controller: controller.messageScrollController,
                    padding: const EdgeInsets.only(bottom: 30),
                    itemBuilder: (_, index) {
                      return MessageListItem(
                        isAlignmentDynamic: true,
                        loginId: controller.userData!.userid ?? '0',
                        messageData: controller.messages[index],
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const Divider(
                        height: 2,
                      );
                    },
                    itemCount: controller.messages.length),
              ),
            ),
          ),
          BroncoSendMessageTextFormField(
            controller: controller.messageTextEditController,
            submitIcon: Obx(() {
              switch (Status.values[controller.messageTabState.value]) {
                case Status.loading:
                  return const MessageLoading();
                case Status.ideal:
                case Status.success:
                case Status.error:
                case Status.successWithEmptyList:
                  return InkWell(
                    onTap: controller.onMessageSentTap,
                    child: const MessageSubmit(),
                  );
              }
            }),
          )
        ],
      ),
    );
  }
}
