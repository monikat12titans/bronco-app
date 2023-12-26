///
/// This class contains all URL which is being called to fetch data from server
///
class ApiClient {
  static String baseServerPath =
      'https://shipping.bronco-trucking.com/broncoapp/';
  static String baseUrl = '${baseServerPath}index.php/';

  final String jsonHeaderName = 'Content-Type';
  final String jsonHeaderValue = 'application/json; charset=UTF-8';
  static const String contentType = 'application/json; charset=UTF-8';
  final int successResponse = 200;

  Map<String, String> getJsonHeader() {
    final header = <String, String>{};
    header[jsonHeaderName] = jsonHeaderValue;
    return header;
  }

  static final String post = '${baseUrl}posts';
  static const String customerList = 'user/?type=3';
  static const String deliveryDriverList = 'driver/get_delivery_driver';
  static const String orderList = 'order/';
  static const String orderListByCustomerId = 'customer/orders/?customer_id';
  static const String messageListByCustomerId =
      'messages/customer_messages/?customerid';
  static const String orderStatus = 'order/orderstatus/?mbn';
  static const String search = 'order/search_order/?s';
  static const String searchHouse = 'house/search_order/?s';
  static const String adminMessageList = 'messages/';
  static const String invoiceListByCustomerId =
      'invoices/customer_invoice/?customerid';
  static const String outstandingInvoiceListByCustomerId =
      'invoices/customer_outstanding_invoice/?customerid';
  static const String deliveryCheckList = 'driver/delivery_checklist';
  static const String deliveryDriverCheckList =
      'driver/delivery_driver_checklist/?driverid';
  static const String pickUpCheckListForSubmitOffice =
      'driver/pickup_driver_checklist/?driverid';
  static const String pickUpCheckList = 'driver/pickup_checklist';
  static const String combinePickUpCheckList =
      'driver/combine_pickupchecklist/?driverid';
  static const String uploadPickPOD = 'driver/verify_pickup';
  static const String uploadDeliveryPOD = 'driver/verify_delivery';
  static const String addBillable = 'order/add_billable';
  static const String addDriver = 'user/add_driver';
  static const String addCustomer = 'user/add_customer';
  static const String dropAtCityOffice = 'driver/drop_at_cityoffice';
  static const String sendCustomerMessage = 'messages/add_messages';
  static const String register = 'login/register_user';
  static const String forgotPassword = 'user/forget_password/?';
  static const String assignMultipleOrderToDeliveryDriver =
      'order/assign_mulipleorder_todelivery_driver';
  static const String assignMultipleOrderToCustomer =
      'order/assign_mulipleorder_tocustomer';
  static const String addHouseNumber = 'house/add_house/?house_no=';
  static const String houseList = 'house/';
}
