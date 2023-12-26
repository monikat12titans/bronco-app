import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/message_data.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/message_list_response.dart';
import 'package:bronco_trucking/models/response/order_data.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/dashboard/customer/select_mawb_payment/select_mawb_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../global_controller.dart';

class CustomerDashboardController extends GetxController with APIState {
  List<OrderData> packageList = [];
  List<OrderData> outstandingInvoiceList = [];
  List<MessageData> messages = [];
  List<OrderData> invoicedList = <OrderData>[];

  RxBool isExpandedPOD = false.obs;
  RxBool isExpandedOutStandingInvoices = false.obs;
  RxInt selectedTab = 0.obs;
  RxInt initialTabLabelIndex = (-1).obs;
  RxBool isExpandedOutstanding = false.obs;
  RxInt previewOutstandingInvoiceSelected = (-1).obs;
  RxInt invoiceTabState = Status.ideal.index.obs;
  RxInt messageTabState = Status.ideal.index.obs;
  RxInt messageSendState = Status.ideal.index.obs;

  late UserData? userData;
  String errorMessage = '';

  List<String> label = const [
    StringConstants.labelShipments,
    StringConstants.labelInvoices,
    StringConstants.labelMessages
  ];

  List<String> pngs = const [
    PNGPath.packages,
    PNGPath.invoices,
    PNGPath.messages
  ];

  final ScrollController messageScrollController = ScrollController();
  final TextEditingController messageTextEditController =
      TextEditingController();

  int get selectedTabIndex =>
      initialTabLabelIndex.value == -1 ? -1 : selectedTab.value;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getOrderList();
  }

  Future<void> onTabChange(int tabIndex) async {
    selectedTab.value = tabIndex;
    initialTabLabelIndex.value = tabIndex;
    for (final invoice in outstandingInvoiceList) {
      invoice.isSelected.value = false;
    }
    previewOutstandingInvoiceSelected.value = -1;

    if (tabIndex == 1) {
      invoiceTabAPICall();
    }
    if (tabIndex == 2) {
      messages.clear();
      messageTabAPICall(false);
    }
  }

  void onMakeAPaymentTap({bool isDesktop = false}) {
    initialTabLabelIndex.value == -1
        ? isDesktop
            ? openSelectMAWBPaymentDialog()
            : Get.toNamed(RouteName.selectMAWBPayment)
        : Get.toNamed(RouteName.invoicePaymentDetail,
            arguments: outstandingInvoiceList[
                previewOutstandingInvoiceSelected.value]);
  }

  Future<void> toExpandPOD({bool hasExpand = false}) async {
    isExpandedPOD.value = hasExpand;
  }

  Future<void> toExpandInvoiceItem(int index, {bool hasExpand = false}) async {
    invoicedList[index].isExpanded.value = hasExpand;
  }

  Future<void> toExpandOutstandInvoice({bool hasExpand = false}) async {
    isExpandedOutStandingInvoices.value = hasExpand;
  }

  Future<void> toExpandInvoices({bool hasExpand = false}) async {
    isExpandedOutStandingInvoices.value = hasExpand;
  }

  void btnLogoutTap() {
    Get.find<GlobalController>().btnLogoutTap(Get.context!);
  }

  void onRadioTap(int index) {
    if (outstandingInvoiceList[index].isSelected.isTrue) return;
    if (index != previewOutstandingInvoiceSelected.value) {
      if (previewOutstandingInvoiceSelected.value != -1) {
        outstandingInvoiceList[previewOutstandingInvoiceSelected.value]
            .isSelected
            .value = false;
      }
      outstandingInvoiceList[index].isSelected.value = true;
      previewOutstandingInvoiceSelected.value = index;
    }
  }

  Future<void> getOrderList() async {
    userData = await AppComponentBase.instance.sharedPreference.getUserData();
    setAPIState(Status.loading);
    packageList.clear();
    AppComponentBase.instance.showProgressDialog();
    final OrderListResponse orderListResponse = await AppComponentBase
        .instance.apiProvider
        .getCustomerOrderById(userData!.userid ?? '0');

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      packageList.addAll(orderListResponse.data ?? []);

      setAPIState(
          packageList.isEmpty ? Status.successWithEmptyList : Status.success);
    } else {
      setAPIState(Status.error);
      errorMessage = orderListResponse.errorMessage;
      Utils.displaySnack(message: orderListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  Future<void> invoiceTabAPICall() async {
    invoiceTabState.value = Status.loading.index;
    AppComponentBase.instance.showProgressDialog();
    Future.wait([getInvoiceList(), getOutstandingInvoiceList()]).then((value) {
      var invoiceListResponse = value[0];
      var outstandingInvoiceListResponse = value[1];
      invoiceTabState.value = Status.success.index;
      invoicedList.clear();
      outstandingInvoiceList.clear();
      if (outstandingInvoiceListResponse.isOKay) {
        outstandingInvoiceList
            .addAll(outstandingInvoiceListResponse.data ?? []);
      }
      if (invoiceListResponse.isOKay) {
        invoicedList.addAll(invoiceListResponse.data ?? []);
      }
      AppComponentBase.instance.hideProgressDialog();
    });
  }

  Future<void> messageTabAPICall(bool isRefreshFromLastAddedMessage) async {
    userData ??= await AppComponentBase.instance.sharedPreference.getUserData();
    messageTabState.value = Status.loading.index;
    AppComponentBase.instance.showProgressDialog();
    final MessageListResponse messageListResponse = await AppComponentBase
        .instance.apiProvider
        .getCustomerMessageList(userData!.userid ?? '0');

    if (messageListResponse.isOKay && messageListResponse.data != null) {
      if (isRefreshFromLastAddedMessage) {
        messages.add(messageListResponse.data!.last);
      } else {
        messages.addAll(messageListResponse.data ?? []);
      }
      messageTabState.value = messages.isEmpty
          ? Status.successWithEmptyList.index
          : Status.success.index;

      await Future.delayed(const Duration(milliseconds: 300));
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        messageScrollController.animateTo(
            messageScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn);
      });
    } else {
      messageTabState.value = Status.error.index;
      Utils.displaySnack(message: messageListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }

  Future<OrderListResponse> getInvoiceList() async {
    userData ??= await AppComponentBase.instance.sharedPreference.getUserData();
    return AppComponentBase.instance.apiProvider
        .getCustomerInvoiceListById(userData!.userid ?? '0');
  }

  Future<OrderListResponse> getOutstandingInvoiceList() async {
    userData ??= await AppComponentBase.instance.sharedPreference.getUserData();
    return AppComponentBase.instance.apiProvider
        .getCustomerOutstandingInvoiceListById(userData!.userid ?? '0');
  }

  void onOpenOutstandingInvoiceTap(OrderData orderData) {
    Get.toNamed(RouteName.invoicePaymentDetail, arguments: orderData);
  }

  Future<void> onMessageSentTap() async {
    if (messageTextEditController.text.isEmpty) {
      Utils.displaySnack(
        message: StringConstants.errorEnterText,
      );
      return;
    }
    messageSendState.value = Status.loading.index;
    final APIStatus apiStatus = await AppComponentBase.instance.apiProvider
        .sendCustomerMessage(
            userData!.userid ?? '0', messageTextEditController.text.trim(), '');

    if (apiStatus.isOKay) {
      messageSendState.value = Status.success.index;
      messageTextEditController.text = '';

      messageTabAPICall(true);
    } else {
      messageSendState.value = Status.error.index;
      Utils.displaySnack(message: apiStatus.errorMessage);
    }
  }

  void openSelectMAWBPaymentDialog() {
    SelectMAWBPaymentController controller = SelectMAWBPaymentController();
    Future.delayed(const Duration(milliseconds: 600))
        .then((value) => controller.onInit());
    Get.defaultDialog(
        title: StringConstants.labelSelectMAWB,
        titleStyle: const TextStyle(
            fontWeight: FontWeight.w600, fontFamily: FontFamily.OpenSans),
        content: SizedBox(
          height: Get.height * 0.8,
          width: Get.width * 0.4,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isSuccess) {
                    return ScrollConfiguration(
                      behavior: const ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: AppTheme.of(Get.context!).primaryColor,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          itemBuilder: (_, index) {
                            var data = controller.searchOrderList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () => controller.onRadioTap(data),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(
                                      () => BroncoRadio(
                                          isSelected: data.isSelected.value),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${StringConstants.labelMAWB} #${data.mbn}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 40.sp,
                                              color: Colors.black87,
                                              fontFamily: FontFamily.OpenSans),
                                        ),
                                        Text(
                                          '${StringConstants.labelInvoiceId} : ${data.invoiceId}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 25.sp,
                                              color: Colors.black87,
                                              fontFamily: FontFamily.OpenSans),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                '${StringConstants.labelTotalAmount} : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 35.sp,
                                                color: Colors.black,
                                                fontFamily:
                                                    FontFamily.OpenSans),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      ' \$${data.totalAmount}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 35.sp,
                                                      color: Colors.black54,
                                                      fontFamily:
                                                          FontFamily.OpenSans)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const Divider(
                              height: 2,
                            );
                          },
                          itemCount: controller.searchOrderList.length,
                        ),
                      ),
                    );
                  }
                  if (controller.isSuccessWithEmptyList) {
                    return const EmptyListErrorText();
                  }
                  if (controller.isError) {
                    return ErrorText(
                      errorMessage: controller.error,
                    );
                  }
                  return const Offstage();
                }),
              ),
              Obx(() {
                if (controller.isSuccess) {
                  return BroncoButton(
                    width: 120,
                    onPress: () => controller.onSubmitTap(),
                    text: StringConstants.btnPayNow.toUpperCase(),
                    hasGradientBg: false,
                    blurRadius: 0,
                    rounder: 0,
                  );
                }
                return const Offstage();
              })
            ],
          ),
        ));
  }
}
