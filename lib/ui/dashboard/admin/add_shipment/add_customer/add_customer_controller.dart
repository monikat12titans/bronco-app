import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/request/add_user_request.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCustomerController extends GetxController with Validator {
  TextEditingController firstNameTextEditController = TextEditingController();
  TextEditingController lastNameTextEditController = TextEditingController();
  TextEditingController addressTextEditController = TextEditingController();
  TextEditingController emailAddressTextEditController =
      TextEditingController();
  TextEditingController phoneNumberTextEditController = TextEditingController();
  TextEditingController passwordTextEditController = TextEditingController();
  TextEditingController cityTextEditController = TextEditingController();
  TextEditingController stateTextEditController = TextEditingController();
  TextEditingController zipTextEditController = TextEditingController();

  Future<void> btnSubmitTap(GlobalKey<FormState> formKey,
      {bool isKeyboardOpen = false}) async {
    if (formKey.currentState!.validate()) {
      AppComponentBase.instance.showProgressDialog();
      var addCustomer = AddUserRequest.empty()
        ..firstName = firstNameTextEditController.text
        ..lastName = lastNameTextEditController.text
        ..email = emailAddressTextEditController.text
        ..phoneNumber = phoneNumberTextEditController.text
        ..address = addressTextEditController.text
        ..city = cityTextEditController.text
        ..state = stateTextEditController.text
        ..zipCode = zipTextEditController.text;

      final APIStatus apiStatus =
          await AppComponentBase.instance.apiProvider.addCustomer(addCustomer);

      Utils.displaySnack(
          message: apiStatus.message, isSuccess: apiStatus.isOKay);

      AppComponentBase.instance.hideProgressDialog();
      if (isKeyboardOpen) Get.back();
      if (apiStatus.isOKay) {
        await Future.delayed(const Duration(seconds: 3));
        Get.back(result: true);
      }
    }
  }
}
