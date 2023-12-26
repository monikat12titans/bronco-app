import 'package:bronco_trucking/models/response/login_response.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with Validator {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt iamGroupValue = LoginType.customer.index.obs;

  Future<void> onRadioTap(LoginType type) async {
    iamGroupValue.value = type.index;
  }

  @override
  void onInit() {
    super.onInit();
    printInfo(info: 'LoginController,onInit ');
  }

  @override
  void dispose() {
    super.dispose();
    userEmailController.dispose();
    passwordController.dispose();
    printInfo(info: 'LoginController,dispose');
  }

  @override
  void onClose() {
    super.onClose();

    printInfo(info: 'LoginController,onClose');
  }

  Future<void> btnSignInPress(GlobalKey<FormState> loginFormKey) async {
    if (loginFormKey.currentState!.validate()) {
      String pageName = _getDashboardPage();
      AppComponentBase.instance.showProgressDialog();
      var response = await AppComponentBase.instance.apiProvider.login(
          userEmailController.text,
          passwordController.text,
          iamGroupValue.value + 1);

      if (response is LoginResponse) {
        if (response.isOKay) {
          //save data in sharePreference
          AppComponentBase.instance.sharedPreference.setIsLogin();
          AppComponentBase.instance.sharedPreference
              .setUserData(response.data!);
          AppComponentBase.instance.sharedPreference
              .setLoginType(LoginType.values[iamGroupValue.value]);
          Get.offAndToNamed(pageName);
        } else {
          Utils.displaySnack(message: response.errorMessage);
        }
      } else {
        Utils.displaySnack();
      }
      AppComponentBase.instance.hideProgressDialog();
    }
  }

  String _getDashboardPage() {
    switch (LoginType.values[iamGroupValue.value]) {
      case LoginType.admin:
        return RouteName.adminDashboardPage;
      case LoginType.customer:
        return RouteName.customerDashboardPage;
      case LoginType.driver:
        return RouteName.driveDashboardPage;
    }
  }
}
