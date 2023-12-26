import 'package:bronco_trucking/models/response/api_states.dart';

class OrderStatusResponse extends APIStatus {
  List<OrderStatusData>? data;

  OrderStatusResponse(int status, int code, String message, this.data)
      : super(status: status, code: code, message: message);

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) {
    var data = <OrderStatusData>[];
    if (json['data'] != null && json['data'] is! bool) {
      json['data'].forEach((v) {
        data.add(OrderStatusData.fromJson(v as Map<String, dynamic>));
      });
    }
    return OrderStatusResponse(json['status'] as int, json['code'] as int,
        json['message'] as String, data);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> r = <String, dynamic>{};
    if (data != null) {
      r['data'] = data!.map((v) => v.toJson()).toList();
    }
    r['status'] = status;
    r['code'] = code;
    r['message'] = message;
    return r;
  }
}

class OrderStatusData {
  String? statusId;
  String? orderStatus;
  String? timestmap;

  OrderStatusData(
      {required this.statusId,
      required this.orderStatus,
      required this.timestmap});

  OrderStatusData.fromJson(Map<String, dynamic> json) {
    statusId = json['statusid'] == null ? '' : json['statusid'] as String;
    timestmap = json['timestmap'] == null ? '' : json['timestmap'] as String;
    orderStatus =
        json['order_status'] == null ? '' : json['order_status'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusid'] = statusId;
    data['order_status'] = orderStatus;
    data['timestmap'] = timestmap;
    return data;
  }
}
