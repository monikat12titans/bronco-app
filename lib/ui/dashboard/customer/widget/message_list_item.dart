import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/message_data.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';

class MessageListItem extends StatelessWidget {
  final MessageData messageData;
  final bool isLastItem;
  final String loginId;
  final bool isAlignmentDynamic;
  final bool hasReplyLabel;
  final Function()? onReplyTap;
  final bool isFromAdmin;

  const MessageListItem({
    required this.messageData,
    required this.loginId,
    Key? key,
    this.isLastItem = false,
    this.isAlignmentDynamic = false,
    this.hasReplyLabel = false,
    this.onReplyTap,
    this.isFromAdmin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: isAlignmentDynamic
            ? Utils.isSelfMessage(loginId, messageData.customerId ?? '')
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            '${messageData.clientName}',
            style: TextStyle(
                fontSize: 35.sp,
                fontWeight: FontWeight.w800,
                fontFamily: FontFamily.OpenSans,
                color: Colors.black),
          ),
          if (isFromAdmin && messageData.replyName!.isNotEmpty) ...[
            Text(
              'To : ${messageData.replyName}',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.OpenSans,
                  color: Colors.black38),
            ),
          ],
          const SizedBox(
            height: 10,
          ),
          Text(
            messageData.messageText ?? '',
            style: TextStyle(
                fontSize: 40.sp,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.OpenSans,
                color: Colors.black87),
          ),
          Text(
            messageData.datetime ?? '',
            style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.OpenSans,
                color: Colors.black54),
          ),
          if (hasReplyLabel)
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => onReplyTap?.call(),
                child: Container(
                  width: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    StringConstants.labelReply,
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.OpenSans,
                        color: Colors.black54),
                  ),
                ),
              ),
            ),
          if (isLastItem)
            const SizedBox(
              height: 70,
            )
        ],
      ),
    );
  }
}
