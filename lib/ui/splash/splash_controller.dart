import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkAuthentication();
    print('----onInit-');
    super.onInit();
  }

  @override
  void onReady() {
    print('----onReady-');
    super.onReady();
  }

  void checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 3));
   //Get.offAndToNamed(RouteName.paymentPage);

    var isLogin = await AppComponentBase.instance.sharedPreference.isLogin();
    if (isLogin) {
      var userType =
          await AppComponentBase.instance.sharedPreference.getLoginType();
      Get.offAndToNamed(getDashboardPage(userType.index));
    } else {
      Get.offAndToNamed(RouteName.loginPage);
    }
  }
}

String getDashboardPage(int userType) {
  switch (LoginType.values[userType]) {
    case LoginType.admin:
      return RouteName.adminDashboardPage;
    case LoginType.customer:
      return RouteName.customerDashboardPage;
    case LoginType.driver:
      return RouteName.driveDashboardPage;
  }
}
