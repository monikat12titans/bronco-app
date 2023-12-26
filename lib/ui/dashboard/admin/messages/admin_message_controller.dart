import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/customer_data.dart';
import 'package:bronco_trucking/models/message_data.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/message_list_response.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class AdminMessageController extends GetxController with APIState {
  late UserData? userData;

  // late CustomerData? customerUserData;

  RxList<MessageData> messages = <MessageData>[].obs;
  RxString customerName = ''.obs;
  RxInt customerId = 0.obs;
  final ScrollController messageScrollController = ScrollController();
  final TextEditingController messageTextEditController =
      TextEditingController();

  final TextEditingController replyTextEditController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getMessages(false);
  }

  Future<void> onMessageSentTap() async {
    if (messageTextEditController.text.isEmpty) {
      Utils.displaySnack(
        message: StringConstants.errorEnterText,
      );
      return;
    }
    if (customerName.isEmpty) {
      Utils.displaySnack(
        message: StringConstants.errorSelectCustomer,
      );
      return;
    }
    final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
        .sendCustomerMessage(userData!.userid ?? '0',
            messageTextEditController.text.trim(), '${customerId.value}');

    if (apiStatus.isOKay) {
      messageTextEditController.text = '';
      getMessages(true);
    } else {
      Utils.displaySnack(message: apiStatus.errorMessage);
    }
  }

  Future<void> onReplySentTap(String customerId) async {
    if (replyTextEditController.text.isEmpty) {
      Utils.displaySnack(
        message: StringConstants.errorEnterText,
      );
      return;
    }

    final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
        .sendCustomerMessage(userData!.userid ?? '0',
            replyTextEditController.text.trim(), customerId);

    if (apiStatus.isOKay) {
      Get.back();
      await Future.delayed(const Duration(milliseconds: 600));
      replyTextEditController.text = '';
      getMessages(true);
    } else {
      Utils.displaySnack(message: apiStatus.errorMessage);
    }
  }

  Future<void> onSelectCustomerTap() async {
    var result = await Get.toNamed(RouteName.selectCustomer,
        arguments: {0: true, 1: customerName.isEmpty ? -1 : customerId.value});
    if (result != null && result is CustomerData) {
      customerName.value = result.name;
      customerId.value = int.parse(result.id);
    }
  }

  Future<void> getMessages(bool isFromSent) async {
    if (!isFromSent) {
      setAPIState(Status.loading);
      userData = await AppComponentBase.instance.sharedPreference.getUserData();
      messages.clear();
      AppComponentBase.instance.showProgressDialog();
    }

    final MessageListResponse messageListResponse =
        await AppComponentBase.instance.apiProvider.getAdminMessageList();

    if (messageListResponse.isOKay && messageListResponse.data != null) {
      if (isFromSent) {
        messages.add(messageListResponse.data!.last);
      } else {
        messages.addAll(messageListResponse.data ?? []);
        setAPIState(
            messages.isEmpty ? Status.successWithEmptyList : Status.success);
      }
      await Future.delayed(const Duration(milliseconds: 300));
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        messageScrollController.animateTo(
            messageScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn);
      });
    } else {
      setAPIState(Status.error,messageListResponse.errorMessage);
     // Utils.displaySnack(message: messageListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }
}
