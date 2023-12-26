import 'package:get/get.dart';

class OutstandingInvoiceData {
  final int invoiceId;
  final int mbnId;
  final int id;
  final RxBool isSelected;

  OutstandingInvoiceData(
    this.invoiceId,
    this.mbnId,
    this.id,
    this.isSelected,
  );
}
