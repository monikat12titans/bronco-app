import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/house_data.dart';
import 'package:bronco_trucking/models/response/house_list_response.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EnterMAWBController extends GetxController with Validator {
  TextEditingController mawbTextEditController = TextEditingController();
  Rx<HouseData> selectedHouseData = HouseData().obs;
  HouseListResponse? houseListResponse;
  RxList<HouseData> houseList = [HouseData()].obs;
  RxBool isHouseListFetched = false.obs;
  RxBool isValueSelected = true.obs;
  bool isSelectionClicked = false;

  @override
  void onInit() {
    super.onInit();
    getHouseList();
  }

  Future<void> btnSubmitTap(
      GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (!isSelectionClicked) {
        isValueSelected.value = false;
      } else {
        AppComponentBase.instance.showProgressDialog();
        final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
            .addOrder(int.parse(mawbTextEditController.text),
                selectedHouseData.value.houseNo.toString());

        Utils.displaySnack(
            message: apiStatus.errorMessage, isSuccess: apiStatus.isOKay);
        AppComponentBase.instance.hideProgressDialog();

        // Navigate to home screen
        if (apiStatus.isOKay) {
          await Future.delayed(const Duration(seconds: 2));
          if (Get.isDialogOpen!) {
            Get.back();
          }
          Get.toNamed(RouteName.selectCustomer,
              arguments: [mawbTextEditController.text.toString()]);
        }
      }
    } else {
      if (!isSelectionClicked) {
        isValueSelected.value = false;
      }
    }
  }

  Future<void> getHouseList() async {
    AppComponentBase.instance.showProgressDialog();
    houseListResponse =
        await AppComponentBase.instance.apiProvider.getHouseList();
    if (houseListResponse != null &&
        (houseListResponse?.data?.isNotEmpty ?? false)) {
      houseList.clear();
      houseList.addAll(houseListResponse!.data!);
      AppComponentBase.instance.hideProgressDialog();
      selectedHouseData = houseList.first.obs;
      isHouseListFetched.value = true;
    } else {
      AppComponentBase.instance.hideProgressDialog();
      isHouseListFetched.value = false;
    }
  }

  void onChanged(HouseData? selectedHouse) {
    isValueSelected.value = true;
    isSelectionClicked = true;
    selectedHouseData.value = selectedHouse!;
  }
}
