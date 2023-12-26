import 'package:get/get.dart';

class CustomerData {
  final String id;
  final String name;
  final String address;
  final String mobileNum;
  final String emailAddress;

  CustomerData(
      this.id, this.name, this.address, this.mobileNum, this.emailAddress);

  RxBool isSelected = false.obs;
}
