import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/add_digital_signature/add_digital_signature_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';

class AddDigitalSignaturePage
    extends GetResponsiveView<AddDigitalSignatureController> {
  @override
  Widget? builder() {
    return Scaffold(
        body: BroncoAppBar(
            isDeskTop: screen.isDesktop,
            onBackTap: () => Get.back(),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    if (screen.isDesktop)
                      const WebHeader(
                        headerTitle: StringConstants.labelSignature,
                      ),
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints.expand(),
                        color: Colors.white,
                        child: HandSignature(
                          control: controller.handSignatureControl,
                        ),
                      ),
                    ),
                    BroncoButton(
                      text: StringConstants.btnDone.toUpperCase(),
                      onPress: () => controller.btnDoneTap(),
                      rounder: 0,
                      hasGradientBg: false,
                    ),
                  ],
                ),
              ],
            )));
  }
}
