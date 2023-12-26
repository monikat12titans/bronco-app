import 'package:bronco_trucking/di/app_core.dart';
import 'package:get/get.dart';

class Validator {
  String? emptyValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return StringConstants.errorEmptyField;
    } else {
      return null;
    }
  }

  String? emailValidator(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return StringConstants.errorEmptyField;
    } else if (!GetUtils.isEmail(value!)) {
      return StringConstants.errorInvalidEmailField;
    } else {
      return null;
    }
  }

  String? phoneNumberValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return StringConstants.errorEmptyField;
    } else if (!GetUtils.isPhoneNumber(value!)) {
      return StringConstants.errorPhoneNumberField;
    } else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return StringConstants.errorEmptyField;
    } else if (value!.length < 5) {
      return StringConstants.errorPasswordLengthField;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String? value, String password) {
    if (value?.isEmpty ?? true) {
      return StringConstants.errorEmptyField;
    } else if (value!.length < 5) {
      return StringConstants.errorPasswordLengthField;
    } else if (value != password) {
      return StringConstants.errorPasswordNotMatch;
    } else {
      return null;
    }
  }

  String? usernameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return StringConstants.errorEmptyField;
    } else if (!GetUtils.isEmail(value!)) {
      return StringConstants.errorInvalidEmailField;
    }
    return null;
  }
}
