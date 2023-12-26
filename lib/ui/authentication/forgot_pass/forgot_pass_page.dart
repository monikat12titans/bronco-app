import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/common/widgets/rounder_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forgot_pass_controller.dart';

class ForgotPasswordPage extends GetResponsiveView<ForgotPasswordController> {
  @override
  Widget? builder() {
    GlobalKey<FormState> forgotPassForm = GlobalKey<FormState>();

    switch (screen.screenType) {
      case ScreenType.Watch:
      case ScreenType.Phone:
      case ScreenType.Tablet:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FormSection(
                  isPhone: true,
                  forgotPassForm: forgotPassForm,
                  controller: controller),
            ),
          ),
        );
      case ScreenType.Desktop:
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.38),
            child: FormSection(
                isPhone: false,
                forgotPassForm: forgotPassForm,
                controller: controller),
          ),
        );
    }
  }
}

class FormSection extends StatelessWidget {
  const FormSection({
    required this.forgotPassForm,
    required this.isPhone,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FormState> forgotPassForm;
  final ForgotPasswordController controller;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isPhone ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Image.asset(
          PNGPath.appLogo,
          height: 210.h,
        ),
        if (!isPhone)
          SizedBox(
            height: 90.h,
          ),
        Form(
          key: forgotPassForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BroncoTextFormField(
                    rightIcon: Icons.mail,
                    hintText: StringConstants.hintEmail,
                    validator: controller.usernameValidator,
                    controller: controller.emailAddressTextController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isPhone)
          SizedBox(
            height: 30.h,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RounderButton(
            text: StringConstants.btnSubmit.toUpperCase(),
            onPress: () => controller.btnSubmitPress(forgotPassForm),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 30.h,
        )
      ],
    );
  }
}
