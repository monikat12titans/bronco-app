import 'dart:async';

import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController with APIState {
  TextEditingController searchTextEditController = TextEditingController();
  Timer? debounce;
  String errorText = '';
  RxList<OrderData> searchList = <OrderData>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onSearchTextChanged(String text) async {
    if (debounce?.isActive ?? false) {
      debounce?.cancel();
    }
    if (text.isEmpty) {
      searchList.clear();
      setAPIState(Status.ideal);

      return;
    }
    debounce = Timer(const Duration(milliseconds: 800), () async {
      setAPIState(Status.loading);

      OrderListResponse response =
          await AppComponentBase.instance.apiProvider.searchHouse(text);

      if (response.isOKay) {
        searchList.clear();

        searchList.addAll(response.data ?? []);
        setAPIState(
            searchList.isEmpty ? Status.successWithEmptyList : Status.success);
      } else {
        errorText = response.errorMessage;
        setAPIState(Status.error);
        searchList.clear();
      }
    });
  }

  Future<void> onTap() async {}

  @override
  void onClose() {
    debounce?.cancel();
    super.onClose();
  }
}
