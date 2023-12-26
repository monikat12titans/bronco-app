import 'package:get/get.dart';

class DriverData {
  String id;
  String name;

  DriverData(this.id, this.name);

  RxBool isSelected = false.obs;
}
