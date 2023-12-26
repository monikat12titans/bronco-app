import 'package:get/get.dart';

class InvoiceData {
  final int id;
  final String mdnId;
  final String invoiceId;
  final int deliveryStatus;
  final int deliveryStatusTime;
  final String address;
  final bool isPaid;
  final String podImg;
  final int? invoiceTime;
  RxBool isExpanded;
  RxBool isSelected;

  InvoiceData(
    this.id,
    this.mdnId,
    this.deliveryStatus,
    this.deliveryStatusTime,
    this.podImg,
    this.invoiceTime, {
    required this.isExpanded,
    required this.isSelected,
    this.isPaid = false,
    this.invoiceId = '-1',
    this.address = '',
  });
}
