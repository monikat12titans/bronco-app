import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/customer_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_radio.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/select_customer/select_customer_controller.dart';
import 'package:bronco_trucking/ui/dashboard/admin/widget/list_header_label.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCustomerPage extends GetResponsiveView<SelectCustomerController> {
  @override
  Widget? builder() {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screen.isDesktop ? 0 : 50),
        child: controller.isFromMessage
            ? null
            : FloatingActionButton.extended(
                onPressed: () async {
                  var data = await Get.toNamed(RouteName.addCustomer);
                  if (data != null && data is bool && data) {
                    controller.getCustomerListAPI();
                  }
                },
                backgroundColor: AppTheme.of(Get.context!).primaryColor,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  StringConstants.addCustomer,
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            if (screen.isDesktop)
              WebHeader(
                headerTitle: StringConstants.labelSelectCustomer,
                hasSearch: true,
                searchTextEditController: controller.searchTextEditController,
                onSearchTextChange: controller.onSearchTextChanged,
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '${StringConstants.labelSelectCustomer} ',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 70.sp,
                      letterSpacing: 1.5,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SearchBox(
                  textEditingController: controller.searchTextEditController,
                  onChange: controller.onSearchTextChanged,
                ),
              ),
            ],
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: AppTheme.of(Get.context!).primaryColor,
                  child: Obx(() {
                    if (controller.isSuccess &&
                        controller.searchCustomerDataList.isNotEmpty) {
                      return screen.isDesktop
                          ? DesktopCustomerList(controller: controller)
                          : MobileCustomerList(controller: controller);
                    }
                    if (controller.isSuccessWithEmptyList) {
                      return const EmptyListErrorText();
                    }

                    if (controller.isLoading) return const Offstage();
                    if (controller.isError) return const ErrorText();
                    return const Offstage();
                  }),
                ),
              ),
            ),
            Obx(() {
              if (controller.isSuccess) {
                return Center(
                  child: BroncoButton(
                    onPress: () => controller.isFromMessage
                        ? controller.btnDoneTap()
                        : controller.btnSubmitTap(),
                    text: controller.isFromMessage
                        ? StringConstants.btnDone.toUpperCase()
                        : StringConstants.btnSubmit.toUpperCase(),
                    rounder: screen.isDesktop ? 20 : 0,
                    hasGradientBg: false,
                    blurRadius: 0,
                    width: screen.isDesktop ? 120 : double.infinity,
                  ),
                );
              }
              return const Offstage();
            }),
            if (screen.isDesktop)
              const SizedBox(
                height: 20,
              )
          ],
        ),
      ),
    );
  }
}

class DesktopCustomerList extends StatelessWidget {
  const DesktopCustomerList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SelectCustomerController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constant.webPadding, vertical: 10),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            CustomerListHeader(),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  itemBuilder: (_, index) {
                    var data = controller.searchCustomerDataList[index];
                    return ResponsiveCustomerListItem(
                      index: index,
                      isDesktop: true,
                      key: ValueKey(data.id),
                      customerData: data,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: controller.searchCustomerDataList.length),
            )
          ],
        ),
      ),
    );
  }
}

class MobileCustomerList extends StatelessWidget {
  const MobileCustomerList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SelectCustomerController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 60),
        itemBuilder: (_, index) {
          var data = controller.searchCustomerDataList[index];
          return ResponsiveCustomerListItem(
            index: index,
            key: ValueKey(data.id),
            customerData: data,
          );
        },
        separatorBuilder: (_, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: controller.searchCustomerDataList.length);
  }
}

class CustomerListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: const [
            SizedBox(
              width: 30,
            ), // Radio buttom
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  textColor: Colors.white,
                  label: StringConstants.labelName,
                )),
            Expanded(
                flex: 2,
                child: ListHeaderLabel(
                  textColor: Colors.white,
                  label: StringConstants.labelAddress,
                )),
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  textColor: Colors.white,
                  label: StringConstants.labelEmail,
                )),
            Expanded(
                flex: 1,
                child: ListHeaderLabel(
                  textColor: Colors.white,
                  label: StringConstants.labelPhoneNo,
                )),
          ],
        ),
      ),
    );
  }
}

class ResponsiveCustomerListItem extends StatelessWidget {
  final CustomerData customerData;
  final int index;
  final bool isDesktop;

  const ResponsiveCustomerListItem({
    required this.customerData,
    required this.index,
    Key? key,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SelectCustomerController controller =
        Get.find<SelectCustomerController>();

    return InkWell(
      onTap: () =>
          controller.onRadioTap(customerData, !customerData.isSelected.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: BroncoRadio(
                    isSelected: customerData.isSelected.value,
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            if (isDesktop) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    customerData.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 40.sp,
                        color: Colors.black87,
                        fontFamily: FontFamily.OpenSans),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    customerData.address,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 37.sp,
                        color: Colors.black54,
                        fontFamily: FontFamily.OpenSans),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    customerData.emailAddress,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 35.sp,
                        color: Colors.black54,
                        fontFamily: FontFamily.OpenSans),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    customerData.mobileNum,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35.sp,
                        color: Colors.black54,
                        fontFamily: FontFamily.OpenSans),
                  ),
                ),
              )
            ],
            if (!isDesktop)
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerData.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 40.sp,
                          color: Colors.black87,
                          fontFamily: FontFamily.OpenSans),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      customerData.address,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 37.sp,
                          color: Colors.black54,
                          fontFamily: FontFamily.OpenSans),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      customerData.emailAddress,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 35.sp,
                          color: Colors.black54,
                          fontFamily: FontFamily.OpenSans),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      customerData.mobileNum,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 35.sp,
                          color: Colors.black54,
                          fontFamily: FontFamily.OpenSans),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
