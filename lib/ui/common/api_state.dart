import 'package:get/get.dart';

class APIState {
  RxInt status = Status.ideal.index.obs;
  String message = '';

  bool get isLoading => status.value == Status.loading.index;

  bool get isSuccess => status.value == Status.success.index;

  bool get isError => status.value == Status.error.index;

  bool get isIdeal => status.value == Status.ideal.index;

  String get statusMessage => message;

  bool get isSuccessWithEmptyList =>
      status.value == Status.successWithEmptyList.index;

  void setAPIState(Status apiStatus, [String? message]) {
    status.value = apiStatus.index;
    if (message != null) this.message = message;
  }
}

enum Status { ideal, loading, success, error, successWithEmptyList }
