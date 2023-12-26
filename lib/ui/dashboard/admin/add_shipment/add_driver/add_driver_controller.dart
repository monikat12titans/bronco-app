import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/request/add_user_request.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddDriverController extends GetxController with Validator {
  TextEditingController firstNameTextEditController = TextEditingController();
  TextEditingController lastNameTextEditController = TextEditingController();
  TextEditingController addressTextEditController = TextEditingController();
  TextEditingController emailAddressTextEditController =
      TextEditingController();
  TextEditingController phoneNumberTextEditController = TextEditingController();
  TextEditingController cityTextEditController = TextEditingController();
  TextEditingController stateTextEditController = TextEditingController();
  TextEditingController zipTextEditController = TextEditingController();

  RxInt iamGroupValue = Constant.driverTypePickUp.obs;

  Future<void> onRadioTap(int type) async {
    iamGroupValue.value = type;
  }

  Future<void> btnSubmitTap(GlobalKey<FormState> formKey,
      {bool isKeyboardOpen = false}) async {
    if (formKey.currentState!.validate()) {
      AppComponentBase.instance.showProgressDialog();
      var addDriverUser = AddUserRequest.empty()
        ..firstName = firstNameTextEditController.text
        ..lastName = lastNameTextEditController.text
        ..email = emailAddressTextEditController.text
        ..phoneNumber = phoneNumberTextEditController.text
        ..address = addressTextEditController.text
        ..city = cityTextEditController.text
        ..state = stateTextEditController.text
        ..driverType = iamGroupValue.value
        ..zipCode = zipTextEditController.text;

      final APIStatus apiStatus =
          await AppComponentBase.instance.apiProvider.addDriver(addDriverUser);

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
