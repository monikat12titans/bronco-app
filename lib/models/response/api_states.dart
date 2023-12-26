class APIStatus {
  String message;
  int code;
  int status;

  bool get isOKay => code == 200;

  String get errorMessage => message;

  APIStatus(
      {this.message = 'Something went wrong',
      this.code = 501,
      this.status = -1});

  factory APIStatus.fromJson(Map<String, dynamic> json) {
    return APIStatus(
        message: json['message'] as String,
        code: json['code'] as int,
        status: json['status'] as int);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
