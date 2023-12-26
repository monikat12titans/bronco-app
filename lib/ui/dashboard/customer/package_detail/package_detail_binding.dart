import 'package:bronco_trucking/ui/dashboard/customer/package_detail/package_detail_controller.dart';
import 'package:get/get.dart';

class PackageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageDetailController>(
      () => PackageDetailController(),
    );
  }
}
