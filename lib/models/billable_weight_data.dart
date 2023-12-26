import 'package:get/get.dart';

class BillableWeightData {
  final int id;
  int mbnId;
  RxDouble weight;
  RxDouble length;
  RxDouble height;
  RxDouble amount;
  RxDouble tax;

  BillableWeightData(this.id, this.mbnId, this.weight, this.length, this.height,
      this.amount, this.tax);

  RxBool isExpanded = false.obs;

  double? get total =>
      double.parse((amount.value + tax.value).toStringAsFixed(4));
}
