import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/models/order_status_model.dart';
import 'package:bronco_trucking/ui/common/api_state.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:get/get.dart';

class OrderStatusController extends GetxController with APIState {
  List<String> orderStatus = [
    'Order Created',
    'Assigned to Warehouse Driver',
    'Picked up at Warehouse',
    'Shipment Recovered',
    'Assigned to Delivery Driver',
    'Out for Delivery',
    'Order Delivered'
  ];

  List<OrderStatusData> orderStatusResponse = [];
  String? mawbId;
  bool isForAdmin = false;
  List<int> passedOrderStatus = [];

  @override
  void onInit() {
    var argument = Get.arguments as Map;
    mawbId = argument[Constant.argumentMBN] as String;
    isForAdmin = argument[Constant.argumentIsForAdmin] as bool;
    getOrderStatusList();
    super.onInit();
  }

  String getTimestamp(int index) {
    var indexI = index;
    indexI++;
    var list = orderStatusResponse
        .where((element) => int.parse(element.statusId ?? '-1') == (indexI))
        .toList();

    if (list.isNotEmpty) {
      return list.first.timestmap ?? '';
    } else {
      return '';
    }
  }

  bool isCompleted(int index) {
    var indexI = index;
    indexI++;
    return passedOrderStatus.contains(indexI);
  }

  Future<void> getOrderStatusList() async {
    setAPIState(Status.loading);
    orderStatusResponse.clear();

    AppComponentBase.instance.showProgressDialog();
    OrderStatusResponse orderListResponse = await AppComponentBase
        .instance.apiProvider
        .getOrderStatus(mawbId ?? '0');

    if (orderListResponse.isOKay && orderListResponse.data != null) {
      setAPIState(orderListResponse.data!.isEmpty
          ? Status.successWithEmptyList
          : Status.success);
      orderStatusResponse.addAll(orderListResponse.data ?? []);
      passedOrderStatus = orderStatusResponse
          .map((e) => int.parse(e.statusId ?? '-1'))
          .toList();
    } else {
      setAPIState(Status.error);
      Utils.displaySnack(message: orderListResponse.errorMessage);
    }
    AppComponentBase.instance.hideProgressDialog();
  }
}
