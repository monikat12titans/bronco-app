import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/payment/payment_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPage extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BroncoAppBar(
        onBackTap: () => Get.back(),
        child: const Center(
          child: Text('Work In Progress....\n\n Under Construction :('),
        ),
      ),
    );
  }
}
