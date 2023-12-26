import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController with Validator {
  TextEditingController emailAddressTextController = TextEditingController();

  Future<void> btnSubmitPress(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      AppComponentBase.instance.showProgressDialog();
      final APIStatus response = await AppComponentBase.instance.apiProvider
          .forgotPass(emailAddressTextController.text);

      Utils.displaySnack(
          message: response.isOKay
              ? StringConstants.msgForgotSuccess
              : response.message,
          isSuccess: response.isOKay);

      AppComponentBase.instance.hideProgressDialog();
      if (response.isOKay) {
        await Future.delayed(const Duration(seconds: 4));
        Get.back();
      }
    }
  }
}
