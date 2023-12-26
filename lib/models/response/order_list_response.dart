import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/order_data.dart';

class OrderListResponse extends APIStatus {
  List<OrderData>? data;
  List<OrderData>? myList;

  OrderListResponse(
      int status, int code, String message, this.data, this.myList)
      : super(status: status, code: code, message: message);

  List<OrderData> get newItem => data ?? [];

  List<OrderData> get myItem => myList ?? [];

  factory OrderListResponse.fromJson(Map<String, dynamic> json) {
    var data = <OrderData>[];
    var myList = <OrderData>[];
    if (json['data'] != null && json['data'] is! bool) {
      json['data'].forEach((v) {
        data.add(OrderData.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['mylist'] != null && json['mylist'] is! bool) {
      json['mylist'].forEach((v) {
        myList.add(OrderData.fromJson(v as Map<String, dynamic>));
      });
    }
    return OrderListResponse(json['status'] as int, json['code'] as int,
        json['message'] as String, data, myList);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> r = <String, dynamic>{};
    if (data != null) {
      r['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (myList != null) {
      r['mylist'] = myList!.map((v) => v.toJson()).toList();
    }
    r['status'] = status;
    r['code'] = code;
    r['message'] = message;
    return r;
  }
}
