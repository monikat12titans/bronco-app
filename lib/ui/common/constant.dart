import 'package:bronco_trucking/ui/common/strings.dart';

class Constant {
  static String token = 'pre_token';
  static String preIsLogin = 'pre_isLogin';
  static String preLoginType = 'pre_login_type';
  static String preUserData = 'pre_user_data';

  static String stripeId =
      'pk_test_51Jgqa4SBfEMjupYfL7ivSDBoZRpEfgANhc5Y3zLqIo2Otez9o5FCh9dXPL6EQh6CpiO9vR9AynCCwTm7nZHFaqKi004003ZG6A';

  static String argumentIsNeedAPICall = 'need_api_call';
  static String argumentList = 'list';
  static String argumentMBN = 'mbn';
  static String argumentIsForAdmin = 'isForAdmin';
  static String argumentFrom = 'uploadFrom';
  static String argumentOrder = 'order';

  //static String argumentIsPickUp = 'isPickUp';
  //static String argumentNeedAPI = 'needAPI';

  //static String argumentIsAssignedToPickUpDriver = 'isAssignedToPickUpDriver';
  static String argumentIsSuccess = 'isSuccess';
  static String argumentMessage = 'message';
  static String argumentProductImage = 'productImage';
  static String argumentSignature = 'signature';

  static String argumentIsFromAssignDriver = 'isFromAssignDriver';

  static const double appHorizontalPadding = 20;
  static const double appTopMargin = 10;

  static const int driverTypeDelivery = 2;
  static const int driverTypePickUp = 1;
  static const int driverTypeBoth = 3;

  static const int orderCreated = 1;
  static const int assignedToPickUpDriver = 2;
  static const int pickUpThroughPickUpDriver = 3;
  static const int dropAtWareHouse = 4;
  static const int assignedToDeliveryDriver = 5;
  static const int pickUpThroughDeliveryDriver = 6;
  static const int deliveryToCustomer = 7;

  static const double webPadding = 45;
}

enum LoginType { admin, driver, customer }
enum RegistrationType { customer, driver }
enum DeliveryStatus {
  inProgress,
  shipped,
  inTransit,
  delivered,
  outOfDelivered
}

enum UploadFrom {
  pickUpCheckIn,
  pickUpSubmitToOffice,
  delivery,
  pickUpSubmitToOfficeSubmit
}

extension DeliveryExtension on DeliveryStatus {
  String get name {
    switch (this) {
      case DeliveryStatus.delivered:
        return StringConstants.labelDelivered;
      case DeliveryStatus.inProgress:
        return StringConstants.labelInProgress;
      case DeliveryStatus.shipped:
        return StringConstants.labelShipped;
      case DeliveryStatus.inTransit:
        return StringConstants.labelInTransit;
      case DeliveryStatus.outOfDelivered:
        return StringConstants.labelOutOfDelivered;
    }
  }
}
