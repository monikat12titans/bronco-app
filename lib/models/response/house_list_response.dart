import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/house_data.dart';

class HouseListResponse extends APIStatus {
  List<HouseData>? data;

  HouseListResponse(
    int status,
    int code,
    String message,
    this.data,
  ) : super(status: status, code: code, message: message);

  factory HouseListResponse.fromJson(dynamic json) {
    var data = <HouseData>[];
    if (json['data'] != null && json['data'] is! bool) {
      json['data'].forEach((v) {
        data.add(HouseData.fromJson(v as Map<String, dynamic>));
      });
    }
    return HouseListResponse(
      json['status'] as int,
      json['code'] as int,
      json['message'] as String,
      data,
    );
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
