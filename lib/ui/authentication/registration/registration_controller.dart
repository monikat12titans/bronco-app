import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/request/registration_request.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController with Validator {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  RxInt iamGroupValue = RegistrationType.customer.index.obs;

  Future<void> btnSignUpPress(GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      AppComponentBase.instance.showProgressDialog();
      var registrationData = Registration.empty()
        ..firstName = firstNameController.text
        ..lastName = lastNameController.text
        ..password = passwordController.text
        ..email = emailAddressController.text
        ..phone = phoneNumberController.text
        ..address = addressController.text
        ..city = cityController.text
        ..state = stateController.text
        ..zip = int.parse(zipController.text)
        ..type = iamGroupValue.value == 0 ? 3 : 2;

      final APIStatus? apiStatus = await AppComponentBase.instance.apiProvider
          .registration(registrationData);
      if (apiStatus != null) {
        Utils.displaySnack(
            message: apiStatus.message, isSuccess: apiStatus.isOKay);
      } else {
        Utils.displaySnack();
      }
      if (apiStatus != null && apiStatus.isOKay) {
        await Future.delayed(const Duration(seconds: 1));
        Get.back();
      }
      AppComponentBase.instance.hideProgressDialog();
    }
  }

  Future<void> onRadioTap(RegistrationType type) async {
    iamGroupValue.value = type.index;
  }
}
