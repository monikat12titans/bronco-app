
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/user_data.dart';

class LoginResponse extends APIStatus {
  UserData? data;

  LoginResponse(int status, int code, String message, this.data)
      : super(status: status, code: code, message: message);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        json['status'] as int,
        json['code'] as int,
        json['message'] as String,
        json['data'] != null && json['data'] is! bool
            ? UserData.fromJson(json['data'] as Map<String, dynamic>)
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data?.toJson();
    return data;
  }
}

