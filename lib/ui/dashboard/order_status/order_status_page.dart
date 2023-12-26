import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'order_status_controller.dart';

class OrderStatusPage extends GetResponsiveView<OrderStatusController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (screen.isDesktop)
              const WebHeader(
                headerTitle: StringConstants.labelOrderStatus,
              ),
            Obx(() {
              if (controller.isSuccess) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            screen.isDesktop ? Constant.webPadding : 15),
                    itemBuilder: (_, index) {
                      return (!controller.isForAdmin &&
                              (index == 1 || index == 4))
                          ? const Offstage()
                          : OrderStatusItem(
                              index: index,
                              isFirst: index == 0,
                              isLast:
                                  index == controller.orderStatus.length - 1,
                              label: controller.orderStatus[index],
                              time: controller.getTimestamp(index),
                              isCompleted: controller.isCompleted(index),
                            );
                    },
                    itemCount: controller.orderStatus.length,
                  ),
                );
              }
              if (controller.isSuccessWithEmptyList) {
                return const EmptyListErrorText();
              }
              if (controller.isError) {
                return const ErrorText();
              }
              return const Offstage();
            })
          ],
        ),
      ),
    );
  }
}

class OrderStatusItem extends StatefulWidget {
  final bool isFirst;
  final bool isLast;
  final String label;
  final String time;
  final bool isCompleted;
  final int index;

  const OrderStatusItem({
    required this.isFirst,
    required this.isLast,
    required this.label,
    required this.time,
    required this.isCompleted,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<OrderStatusItem> createState() => _OrderStatusItemState();
}

class _OrderStatusItemState extends State<OrderStatusItem> {
  bool _animate = false;

  bool _isStart = true;

  @override
  void initState() {
    super.initState();

    _isStart
        ? Future.delayed(Duration(milliseconds: (widget.index * 300) + 600),
            () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 90,
            child: Stack(
              children: [
                Positioned(
                    top: widget.isFirst ? 30 : 0,
                    bottom: widget.isLast ? 30 : 0,
                    left: 0,
                    right: 0,
                    child: const VerticalDivider(
                      color: Colors.grey,
                    )),
                const Positioned.fill(
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      minRadius: 120,
                      child: SizedBox(
                        width: 15,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      opacity: _animate ? 1 : 0,
                      curve: Curves.easeInOutQuart,
                      child: CircleAvatar(
                        backgroundColor:
                            widget.isCompleted ? Colors.green : Colors.grey,
                        minRadius: 120,
                        child: Icon(
                          widget.isCompleted ? Icons.check : Icons.adjust_sharp,
                          color: widget.isCompleted
                              ? Colors.white
                              : Colors.white38,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      color: const Color(0xff536172),
                      fontSize: 45.sp,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.time,
                  style: TextStyle(
                      fontFamily: FontFamily.OpenSans,
                      color: const Color(0xff536172),
                      fontSize: 30.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.black12,
                  height: 10,
                  thickness: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animate = false;
    _isStart = false;
  }
}
