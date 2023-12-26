import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/authentication/registration/registration_controller.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/common/widgets/rounder_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPage extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Image.asset(
              PNGPath.appLogo,
              height: 110.h,
            ),
            SizedBox(
              height: 50.h,
            ),
            Form(
              key: registrationFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BroncoTextFormField(
                      rightIcon: Icons.person,
                      hintText: StringConstants.hintFirstName,
                      validator: controller.emptyValidator,
                      controller: controller.firstNameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.person,
                      hintText: StringConstants.hintLastName,
                      validator: controller.emptyValidator,
                      controller: controller.lastNameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.mail,
                      hintText: StringConstants.hintEmail,
                      validator: controller.emailValidator,
                      controller: controller.emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.lock,
                      hintText: StringConstants.hintPassword,
                      validator: controller.passwordValidator,
                      controller: controller.passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.lock,
                      hintText: StringConstants.hintConfirmPassword,
                      validator: (value) => controller.confirmPasswordValidator(
                          value, controller.passwordController.text),
                      controller: controller.confirmPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.call,
                      hintText: StringConstants.hintPhoneNumber,
                      validator: controller.phoneNumberValidator,
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.add_location,
                      hintText: StringConstants.hintAddress,
                      validator: controller.emptyValidator,
                      controller: controller.addressController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.location_on_outlined,
                      hintText: StringConstants.hintState,
                      validator: controller.emptyValidator,
                      controller: controller.stateController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.location_city,
                      hintText: StringConstants.hintCity,
                      validator: controller.emptyValidator,
                      controller: controller.cityController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BroncoTextFormField(
                      rightIcon: Icons.pin_drop_outlined,
                      hintText: StringConstants.hintZipCode,
                      validator: controller.emptyValidator,
                      controller: controller.zipController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: _RadioItem(
                    registrationController: controller,
                    type: RegistrationType.customer,
                    groupValue: controller.iamGroupValue.value,
                    text: StringConstants.customer,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: _RadioItem(
                  registrationController: controller,
                  type: RegistrationType.driver,
                  groupValue: controller.iamGroupValue.value,
                  text: StringConstants.drive,
                ),
              ),
            ),
            SizedBox(
              height: 90.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RounderButton(
                text: StringConstants.btnSignUp.toUpperCase(),
                onPress: () => controller.btnSignUpPress(registrationFormKey),
              ),
            ),
            SizedBox(
              height: 30.h,
            )
          ],
        ),
      ),
    );
  }
}

class _RadioItem extends StatelessWidget {
  final RegistrationController registrationController;
  final int groupValue;
  final String text;
  final RegistrationType type;

  const _RadioItem({
    required this.registrationController,
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
              registrationController.onRadioTap(type);
            },
          ),
        ),
        GestureDetector(
          onTap: () => registrationController.onRadioTap(type),
          child: Text(
            '${StringConstants.labelIam} $text',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontFamily: FontFamily.OpenSans,
                fontWeight: groupValue == type.index
                    ? FontWeight.w600
                    : FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
