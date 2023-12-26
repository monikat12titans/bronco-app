import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/user_data.dart';

class DriverListResponse extends APIStatus {
  List<UserData>? data;

  DriverListResponse(int status, int code, String message, this.data)
      : super(status: status, code: code, message: message);

  factory DriverListResponse.fromJson(Map<String, dynamic> json) {
    var data = <UserData>[];
    if (json['data'] != null && json['data'] is! bool) {
      json['data'].forEach((v) {
        data.add(UserData.fromJson(v as Map<String, dynamic>));
      });
    }
    return DriverListResponse(json['status'] as int, json['code'] as int,
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
