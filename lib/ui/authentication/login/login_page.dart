import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/ui/common/asset_images.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/common/widgets/rounder_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetResponsiveView<LoginController> {
  @override
  Widget? builder() {
    GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(children: [
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(
                PNGPath.backImage,
                fit: BoxFit.contain,
              )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                SizedBox(
                  height: 250.h,
                ),
                FromSectionResponsive(loginFormKey, controller),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class _Iam extends StatelessWidget {
  final int groupValue;
  final LoginController controller;

  const _Iam({
    required this.groupValue,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RadioItem(
          type: LoginType.customer,
          loginController: controller,
          groupValue: groupValue,
          text: StringConstants.customer,
        ),
        const SizedBox(
          height: 20,
        ),
        _RadioItem(
          type: LoginType.driver,
          loginController: controller,
          groupValue: groupValue,
          text: StringConstants.drive,
        ),
        const SizedBox(
          height: 20,
        ),
        _RadioItem(
          type: LoginType.admin,
          loginController: controller,
          groupValue: groupValue,
          text: StringConstants.admin,
        ),
      ],
    );
  }
}

class _RadioItem extends StatelessWidget {
  final LoginController loginController;
  final int groupValue;
  final String text;
  final LoginType type;

  const _RadioItem({
    required this.loginController,
    required this.groupValue,
    required this.type,
    Key? key,
    this.text = 'Text',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 40,
          child: Radio(
            value: type.index,
            groupValue: groupValue,
            activeColor: AppTheme.of(context).primaryColor,
            onChanged: (_) {
              loginController.onRadioTap(type);
            },
          ),
        ),
        GestureDetector(
          onTap: () => loginController.onRadioTap(type),
          child: Text(
            '${StringConstants.labelIam} $text',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontFamily: FontFamily.OpenSans,
                fontWeight: groupValue == type.index
                    ? FontWeight.bold
                    : FontWeight.w300),
          ),
        ),
      ],
    );
  }
}

class FromSectionResponsive extends GetResponsiveView<LoginController> {
  final GlobalKey<FormState> loginFormKey;
  final LoginController loginController;

  FromSectionResponsive(this.loginFormKey, this.loginController);

  @override
  Widget? builder() {
    switch (screen.screenType) {
      case ScreenType.Watch:
      case ScreenType.Phone:
      case ScreenType.Tablet:
        return Column(
          children: [
            Image.asset(
              PNGPath.appLogo,
              height: 210.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            FromSection(
              loginController: loginController,
              loginFormKey: loginFormKey,
            )
          ],
        );
      case ScreenType.Desktop:
        return SizedBox(
          width: Get.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Image.asset(
                    PNGPath.appLogo,
                    height: 210.h,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  FromSection(
                    loginController: loginController,
                    loginFormKey: loginFormKey,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}

class FromSection extends StatelessWidget {
  final GlobalKey<FormState> loginFormKey;
  final LoginController loginController;

  const FromSection(
      {required this.loginFormKey, required this.loginController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: loginFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BroncoTextFormField(
                  rightIcon: Icons.mail,
                  hintText: StringConstants.hintEmail,
                  validator: loginController.usernameValidator,
                  controller: loginController.userEmailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                BroncoTextFormField(
                  obscureText: true,
                  rightIcon: Icons.lock,
                  hintText: StringConstants.hintPassword,
                  controller: loginController.passwordController,
                  validator: loginController.passwordValidator,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.forgotPage);
                    },
                    child: Text(
                      StringConstants.labelForgot,
                      style: TextStyle(
                          fontFamily: FontFamily.OpenSans,
                          fontWeight: FontWeight.w500,
                          fontSize: 30.sp,
                          color: Colors.black45),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(() => _Iam(
                      controller: loginController,
                      groupValue: loginController.iamGroupValue.value,
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: RounderButton(
            text: StringConstants.btnSignIn.toUpperCase(),
            onPress: () => loginController.btnSignInPress(loginFormKey),
          ),
        )
      ],
    );
  }
}
