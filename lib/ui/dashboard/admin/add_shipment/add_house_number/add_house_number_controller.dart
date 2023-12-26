import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddHouseNumberController extends GetxController with Validator {
  TextEditingController houseNumberTextEditController = TextEditingController();

  Future<void> btnAddTap(
      GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AppComponentBase.instance.showProgressDialog();
      final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
          .addHouseNumber(houseNumberTextEditController.text);
      AppComponentBase.instance.hideProgressDialog();

      // Navigate to home screen
      if (apiStatus.isOKay) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }
      Utils.displaySnack(
        message: apiStatus.errorMessage,
        isSuccess: apiStatus.isOKay,
      );
    }
  }
}
