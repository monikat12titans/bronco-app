import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_text_form_field.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_customer_controller.dart';

class AddCustomerPage extends GetResponsiveView<AddCustomerController> {
  @override
  Widget? builder() {
    GlobalKey<FormState> addCustomerForm = GlobalKey<FormState>();

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
                headerTitle: StringConstants.addCustomer,
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '${StringConstants.addCustomer} ',
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
                padding: EdgeInsets.symmetric(
                    horizontal: screen.isDesktop ? 25 : 12,
                    vertical: screen.isDesktop ? 30 : 0),
                child: SingleChildScrollView(
                  child: Form(
                      key: addCustomerForm,
                      child: screen.isDesktop
                          ? Row(
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25),
                                child: PersonalInformation(
                                    addCustomerController: controller),
                              )),
                          Container(
                            width: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10),
                            height: Get.height * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25),
                                child: AddressInformation(
                                    addCustomerController: controller),
                              ))
                        ],
                      )
                          : Column(
                        children: [
                          PersonalInformation(
                              addCustomerController: controller),
                          const SizedBox(
                            height: 10,
                          ),
                          AddressInformation(
                              addCustomerController: controller)
                        ],
                      )),
                ),
              ),
            ),
            if (screen.isDesktop)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: BroncoButton(
                    onPress: () => controller.btnSubmitTap(addCustomerForm),
                    text: StringConstants.btnSubmit.toUpperCase(),
                    rounder: 20,
                    width: 120,
                    hasGradientBg: false,
                  ),
                ),
              )
            else
              BroncoButton(
                onPress: () => controller.btnSubmitTap(addCustomerForm),
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

class PersonalInformation extends StatelessWidget {
  final AddCustomerController addCustomerController;

  const PersonalInformation({
    required this.addCustomerController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BroncoTextFormField(
          validator: addCustomerController.emptyValidator,
          hintText: StringConstants.hintFirstName,
          rightIcon: Icons.person,
          controller: addCustomerController.firstNameTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          validator: addCustomerController.emptyValidator,
          hintText: StringConstants.hintLastName,
          rightIcon: Icons.person,
          controller: addCustomerController.lastNameTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          validator: addCustomerController.emailValidator,
          hintText: StringConstants.hintEmail,
          rightIcon: Icons.email,
          controller: addCustomerController.emailAddressTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          keyboardType: TextInputType.number,
          rightIcon: Icons.phone,
          validator: addCustomerController.phoneNumberValidator,
          hintText: StringConstants.hintPhoneNumber,
          controller: addCustomerController.phoneNumberTextEditController,
        )
      ],
    );
  }
}

class AddressInformation extends StatelessWidget {
  final AddCustomerController addCustomerController;

  const AddressInformation({required this.addCustomerController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BroncoTextFormField(
          validator: addCustomerController.emptyValidator,
          hintText: StringConstants.hintAddress,
          rightIcon: Icons.location_on,
          controller: addCustomerController.addressTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          rightIcon: Icons.location_city,
          hintText: StringConstants.hintCity,
          validator: addCustomerController.emptyValidator,
          controller: addCustomerController.cityTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          rightIcon: Icons.location_on_outlined,
          hintText: StringConstants.hintState,
          validator: addCustomerController.emptyValidator,
          controller: addCustomerController.stateTextEditController,
        ),
        const SizedBox(
          height: 10,
        ),
        BroncoTextFormField(
          rightIcon: Icons.pin_drop_outlined,
          hintText: StringConstants.hintZipCode,
          validator: addCustomerController.emptyValidator,
          controller: addCustomerController.zipTextEditController,
        ),
      ],
    );
  }
}
