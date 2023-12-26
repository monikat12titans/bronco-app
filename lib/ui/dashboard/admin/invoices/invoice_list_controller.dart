import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/invoice_data.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';

class InvoiceListController extends GetxController {
  RxList<InvoiceData> invoicedList = <InvoiceData>[].obs;
  RxBool isExpandedPOD = false.obs;
  RxBool isExpandedOutStandingInvoices = false.obs;
  RxBool isSelectedAll = false.obs;

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 5; i++) {
      invoicedList.add(InvoiceData(
          i,
          random.numberOfLength(3),
          i,
          1619762307 + (10 * i),
          'https://picsum.photos/200/300',
          i == 3 ? null : 1619768307 + (10 * i),
          address:
              '${faker.address.neighborhood()} ${faker.address.streetAddress()}  ${faker.address.zipCode()}',
          isExpanded: false.obs,
          invoiceId: random.numberOfLength(5),
          isSelected: false.obs,
          isPaid: i == 3));
    }
  }

  void onRadioTap(int index, bool value) {
    if (invoicedList[index].isSelected.value != value) {
      invoicedList[index].isSelected.value = value;
    }
  }

  void onSelectLabelTap() {
    invoicedList.forEach((element) {
      element.isSelected.value = !isSelectedAll.value;
    });

    isSelectedAll.value = !isSelectedAll.value;
  }

  void btnSentTap() {
    bool isAnySelected =
        invoicedList.any((element) => element.isSelected.isTrue);
    if (isAnySelected) {
      Get.back();
    } else {
      Utils.displaySnack(message: StringConstants.errorSelectInvoice);
    }
  }

  Future<void> toExpandInvoiceItem(int index, {bool hasExpand = false}) async {
    invoicedList[index].isExpanded.value = hasExpand;
  }
}
