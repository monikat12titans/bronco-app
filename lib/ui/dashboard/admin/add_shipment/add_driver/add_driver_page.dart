import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_driver_controller.dart';

class AddDriverPage extends GetResponsiveView<AddDriverController> {
  @override
  Widget? builder() {
    GlobalKey<FormState> addDriverForm = GlobalKey<FormState>();

    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            if (screen.isDesktop)
              const WebHeader(
                headerTitle: StringConstants.addDriver,
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  StringConstants.addDriver,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 70.sp,
                      letterSpacing: 1.5,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                ),
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Form(
                      key: addDriverForm,
                      child: screen.isDesktop
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 60),
                                          child: PersonalInformation(
                                              addDriverController: controller),
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: Get.height * 0.4,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20))),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 60),
                                        child: AddressSection(
                                            addDriverController: controller),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: SizedBox(
                                      height: 100,
                                      child: Obx(() => _DriverType(
                                            isDesktop: true,
                                            controller: controller,
                                            groupValue:
                                                controller.iamGroupValue.value,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                PersonalInformation(
                                    addDriverController: controller),
                                const SizedBox(
                                  height: 30,
                                ),
                                AddressSection(addDriverController: controller),
                                Obx(() => _DriverType(
                                      controller: controller,
                                      groupValue:
                                          controller.iamGroupValue.value,
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )),
                ),
              ),
            ),
            if (screen.isDesktop)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: BroncoButton(
                    onPress: () => controller.btnSubmitTap(addDriverForm),
                    text: StringConstants.btnSubmit.toUpperCase(),
                    blurRadius: 0,
                    width: 120,
                    hasGradientBg: false,
                    rounder: 30,
                  ),
                ),
              )
            else
              BroncoButton(
                onPress: () => controller.btnSubmitTap(addDriverForm),
                text: StringConstants.btnSubmit.toUpperCase(),
                blurRadius: 0,
                hasGradientBg: false,
                rounder: 0,
              ),
          ],
        ),
      ),
    );
  }
}

class _DriverType extends StatelessWidget {
  final int groupValue;
  final AddDriverController controller;
  final bool isDesktop;

  const _DriverType({
    required this.groupValue,
    required this.controller,
    Key? key,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${StringConstants.labelDriverType} : ',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontSize: 40.sp,
                fontFamily: FontFamily.OpenSans,
                fontWeight: FontWeight.bold),
          ),
          if (isDesktop) ...[
            _RadioItem(
              type: Constant.driverTypePickUp,
              controller: controller,
              groupValue: groupValue,
              text: StringConstants.pickUp,
            ),
            const SizedBox(
              height: 20,
            ),
            _RadioItem(
              type: Constant.driverTypeDelivery,
              controller: controller,
              groupValue: groupValue,
              text: StringConstants.delivery,
            ),
            const SizedBox(
              height: 20,
            ),
            _RadioItem(
              type: Constant.driverTypeBoth,
              controller: controller,
              groupValue: groupValue,
              text: StringConstants.both,
            )
          ],
          if (!isDesktop)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RadioItem(
                    type: Constant.driverTypePickUp,
                    controller: controller,
                    groupValue: groupValue,
                    text: StringConstants.pickUp,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _RadioItem(
                    type: Constant.driverTypeDelivery,
                    controller: controller,
                    groupValue: groupValue,
                    text: StringConstants.delivery,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _RadioItem(
                    type: Constant.driverTypeBoth,
                    controller: controller,
                    groupValue: groupValue,
                    text: StringConstants.both,
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}

class PersonalInformation extends StatelessWidget {
  final AddDriverController addDriverController;

  const PersonalInformation({required this.addDriverController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BroncoTextFormField(
          validator: addDriverController.emptyValidator,
          hintText: StringConstants.hintFirstName,
          rightIcon: Icons.person,
          controller: addDriverController.firstNameTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          validator: addDriverController.emptyValidator,
          hintText: StringConstants.hintLastName,
          rightIcon: Icons.person,
          controller: addDriverController.lastNameTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          validator: addDriverController.emailValidator,
          hintText: StringConstants.hintEmail,
          rightIcon: Icons.email,
          controller: addDriverController.emailAddressTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          keyboardType: TextInputType.number,
          rightIcon: Icons.phone,
          validator: addDriverController.phoneNumberValidator,
          hintText: StringConstants.hintPhoneNumber,
          controller: addDriverController.phoneNumberTextEditController,
        ),
      ],
    );
  }
}

class AddressSection extends StatelessWidget {
  final AddDriverController addDriverController;

  const AddressSection({required this.addDriverController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BroncoTextFormField(
          validator: addDriverController.emptyValidator,
          hintText: StringConstants.hintAddress,
          rightIcon: Icons.location_on,
          controller: addDriverController.addressTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          rightIcon: Icons.location_city,
          hintText: StringConstants.hintCity,
          validator: addDriverController.emptyValidator,
          controller: addDriverController.cityTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          rightIcon: Icons.location_on_outlined,
          hintText: StringConstants.hintState,
          validator: addDriverController.emptyValidator,
          controller: addDriverController.stateTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          rightIcon: Icons.pin_drop_outlined,
          hintText: StringConstants.hintZipCode,
          validator: addDriverController.emptyValidator,
          controller: addDriverController.zipTextEditController,
        ),
      ],
    );
  }
}

class _RadioItem extends StatelessWidget {
  final AddDriverController controller;
  final int groupValue;
  final String text;
  final int type;

  const _RadioItem({
    required this.controller,
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
            value: type,
            groupValue: groupValue,
            activeColor: AppTheme.of(context).primaryColor,
            onChanged: (_) {
              controller.onRadioTap(type);
            },
          ),
        ),
        GestureDetector(
          onTap: () => controller.onRadioTap(type),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontFamily: FontFamily.OpenSans,
                fontWeight:
                    groupValue == type ? FontWeight.bold : FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
