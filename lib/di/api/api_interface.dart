import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bronco_trucking/di/api/api_client.dart';
import 'package:bronco_trucking/di/api/api_provider.dart';
import 'package:bronco_trucking/di/api/base_api_provider.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/order_status_model.dart';
import 'package:bronco_trucking/models/post.dart';
import 'package:bronco_trucking/models/request/add_user_request.dart';
import 'package:bronco_trucking/models/request/registration_request.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/customer_list_response.dart';
import 'package:bronco_trucking/models/response/driver_list_response.dart';
import 'package:bronco_trucking/models/response/house_list_response.dart';
import 'package:bronco_trucking/models/response/login_response.dart';
import 'package:bronco_trucking/models/response/message_list_response.dart';
import 'package:bronco_trucking/models/response/order_list_response.dart';
import 'package:flutter/foundation.dart';

export 'base_api_provider.dart' hide ProtectedBase;

abstract class APIInterface {
  Future<Response<List<Post>>> getPosts();

  Future<Response<dynamic>> uploadFile(String mawb, File imageFile,
      File signatureFile, bool isPickUp, String driverId);

  Future<Response<dynamic>> webUploadFile(String mawb,
      Uint8List imageFile,
      Uint8List signatureFile,
      bool isPickUp,
      String driverId,
      String imageFileExtension);

  Future<dynamic> login(String userName, String password, int type);

  Future<APIStatus?> registration(Registration registration);

  Future<APIStatus> forgotPass(String email);

  Future<APIStatus> addOrder(int mawb, String houseNumber);

  Future<APIStatus> addDriver(AddUserRequest addUserRequest);

  Future<APIStatus> addCustomer(AddUserRequest addUserRequest);

  Future<APIStatus> assignDriver(List<String> mawbId, int driverId);

  Future<APIStatus> dropAtCityOffice(List<String> mawbId, int driverId);

  Future<APIStatus> assignCustomer(List<String> mawbId, int customerId);

  Future<CustomerListResponse> getCustomerList();

  Future<DriverListResponse> getDriverList();

  Future<OrderListResponse> getOrderList();

  Future<OrderListResponse> getCustomerOrderById(String customerId);

  Future<OrderStatusResponse> getOrderStatus(String mawbId);

  Future<OrderListResponse> getCustomerInvoiceListById(String customerId);

  Future<OrderListResponse> getCustomerOutstandingInvoiceListById(String customerId);

  Future<OrderListResponse> getDeliveryCheckList();

  Future<OrderListResponse> getDeliveryDriverCheckList(String userId);

  Future<OrderListResponse> getMBNListAdmin();

  Future<OrderListResponse> getPickUpCheckListForSubmitOffice(String userId);

  Future<OrderListResponse> getPickUpCheckList(String userId);

  Future<MessageListResponse> getCustomerMessageList(String userId);

  Future<MessageListResponse> getAdminMessageList();

  Future<APIStatus> addBillable(String mawbId, String weight, String length,
      String height, String amount, String tax);

  Future<APIStatus> sendCustomerMessage(
      String customerId, String message, String replyId);

  Future<OrderListResponse> search(String text);

  Future<APIStatus> addHouseNumber(String houseNumber);

  Future<HouseListResponse> getHouseList();

  Future<OrderListResponse> searchHouse(String text);
}

class APIProvider extends APIMethodProvider implements APIInterface {
  @override
  Future<Response<List<Post>>> getPosts() =>
      getMethod(ApiClient.post, decoder: (date) {
        List<Post> list = [];
        if (date != null && date is List && date.isNotEmpty) {
          for (int i = 0; i < date.length; i++) {
            list.add(Post.fromJson(date[i] as Map<String, dynamic>));
          }
          return list;
        } else {
          return [];
        }
      });

  @override
  Future<dynamic> login(String userName, String password, int type) async {
    final formData = FormData(
        {'email': userName, 'password': password, 'type': type.toString()});
    var response = await postMethod('login/?', formData);
    if (response.body is Map<String, dynamic>) {
      return LoginResponse.fromJson(response.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<OrderListResponse> getOrderList() async {
    var data = await getMethod(ApiClient.orderList);
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<APIStatus?> registration(Registration registration) async {
    final formData = FormData({
      'first_name': registration.firstName,
      'last_name': registration.lastName,
      'email': registration.email,
      'password': registration.password,
      'phone': registration.phone,
      'address': registration.address,
      'state': registration.state,
      'city': registration.city,
      'zip': registration.zip,
      'type': '${registration.type}'
    });
    var response = await postMethod(ApiClient.register, formData);
    if (response != null && response.body is Map<String, dynamic>) {
      return APIStatus.fromJson(response.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<APIStatus> forgotPass(String email) async {
    final formData = FormData({'email': email});
    var response = await postMethod(ApiClient.forgotPassword, formData);
    if (response.body is Map<String, dynamic>) {
      return APIStatus.fromJson(response.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<APIStatus> addCustomer(AddUserRequest addUserRequest) async {
    final formData = FormData({
      'first_name': addUserRequest.firstName,
      'last_name': addUserRequest.lastName,
      'email': addUserRequest.email,
      'phone': addUserRequest.phoneNumber,
      'address': addUserRequest.address,
      'state': addUserRequest.state,
      'city': addUserRequest.city,
      'zip': addUserRequest.zipCode,
    });
    var response = await postMethod(ApiClient.addCustomer, formData);
    if (response != null && response.body is Map<String, dynamic>) {
      return APIStatus.fromJson(response.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<APIStatus> addDriver(AddUserRequest addUserRequest) async {
    final formData = FormData({
      'first_name': addUserRequest.firstName,
      'last_name': addUserRequest.lastName,
      'email': addUserRequest.email,
      'phone': addUserRequest.phoneNumber,
      'address': addUserRequest.address,
      'state': addUserRequest.state,
      'city': addUserRequest.city,
      'zip': addUserRequest.zipCode,
      'pickuptype': addUserRequest.driverType,
      'type': '2'
    });
    var response = await postMethod(ApiClient.addDriver, formData);
    if (response != null && response.body is Map<String, dynamic>) {
      return APIStatus.fromJson(response.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<APIStatus> assignCustomer(List<String> mawbId, int customerId) async {
    Map<String, dynamic> mbnMap = {};

    for (int i = 0; i < mawbId.length; i++) {
      mbnMap['mbn[$i]'] = mawbId[i];
    }
    mbnMap['customerid'] = customerId;
    var data = await postMethod(
      ApiClient.assignMultipleOrderToCustomer,
      mbnMap,
      contentType: 'application/x-www-form-urlencoded',
    );

    if (data.body != null && data.body is Map<String, dynamic>) {
      return APIStatus.fromJson(data.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<APIStatus> assignDriver(List<String> mawbId, int driverId) async {
    Map<String, dynamic> mbnMap = {};
    for (int i = 0; i < mawbId.length; i++) {
      mbnMap['mbn[$i]'] = mawbId[i];
    }
    mbnMap['driverid'] = driverId;
    var data = await postMethod(
      ApiClient.assignMultipleOrderToDeliveryDriver,
      mbnMap,
      contentType: 'application/x-www-form-urlencoded',
    );
    if (data.body != null && data.body is Map<String, dynamic>) {
      return APIStatus.fromJson(data.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<CustomerListResponse> getCustomerList() async {
    var data = await getMethod(ApiClient.customerList);
    return data.body is Map<String, dynamic>
        ? CustomerListResponse.fromJson(data.body as Map<String, dynamic>)
        : CustomerListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, []);
  }

  @override
  Future<DriverListResponse> getDriverList() async {
    var data = await getMethod(ApiClient.deliveryDriverList);
    return data.body is Map<String, dynamic>
        ? DriverListResponse.fromJson(data.body as Map<String, dynamic>)
        : DriverListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, []);
  }

  @override
  Future<APIStatus> addOrder(int mawbId, String houseNumber) async {
    var data =
        await getMethod('order/add_order/?mbn=$mawbId&house_no=$houseNumber');
    if (data.body != null && data.body is Map<String, dynamic>) {
      return APIStatus.fromJson(data.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<APIStatus> addHouseNumber(String houseNumber) async {
    var data = await getMethod('${ApiClient.addHouseNumber}$houseNumber');
    if (data.body != null && data.body is Map<String, dynamic>) {
      return APIStatus.fromJson(data.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<OrderListResponse> getDeliveryCheckList() async {
    var data = await getMethod(ApiClient.deliveryCheckList);
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<APIStatus> addBillable(String mawbId, String weight, String length,
    String height, String amount, String tax) async {
    final formData = FormData({
      'mbn': mawbId,
      'weight': weight,
      'length': length,
      'height': height,
      'amount': amount,
      'tax': tax,
    });
    var response = await postMethod(ApiClient.addBillable, formData);
    if (response.body is Map<String, dynamic>) {
      return APIStatus.fromJson(response.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<OrderListResponse> getPickUpCheckList(String userId) async {
    var data = await getMethod('${ApiClient.combinePickUpCheckList}=$userId');
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<Response<dynamic>> uploadFile(String mbn, File? imageFile,
      File? signatureFile, bool isPickup, String driverId) {
    Map<String, dynamic> formMap = {};
    if (imageFile != null) {
      formMap[isPickup ? 'pickup_product_image' : 'delivery_product_image'] =
          MultipartFile(kIsWeb ? imageFile.readAsBytes().asStream() : imageFile,
              filename: '${mbn}_img.${imageFile.path.split('.').last}');
    }
    if (signatureFile != null) {
      formMap[isPickup
          ? 'pickup_driver_signature'
          : 'delivery_driver_signature'] =
          MultipartFile(
              kIsWeb ? signatureFile.readAsBytes().asStream() : signatureFile,
              filename: '${mbn}_sig.png');
    }

    if (isPickup) {
      formMap['driverid'] = driverId;
    }
    formMap['mbn'] = mbn;
    final form = FormData(formMap);

    /*  if(kIsWeb){
      postMethod(
          isPickup ? ApiClient.uploadPickPOD : ApiClient.uploadDeliveryPOD, form).asStream().
    }*/
    return postMethod(
        isPickup ? ApiClient.uploadPickPOD : ApiClient.uploadDeliveryPOD, form);
  }

  @override
  Future<OrderListResponse> getCustomerOrderById(String customerId) async {
    var data =
    await getMethod('${ApiClient.orderListByCustomerId}=$customerId');
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<APIStatus> dropAtCityOffice(List<String> mbnId, int driverId) async {
    Map<String, dynamic> mbnMap = {};
    for (int i = 0; i < mbnId.length; i++) {
      mbnMap['mbn[$i]'] = mbnId[i];
    }
    mbnMap['driverid'] = driverId;
    var data = await postMethod(
      ApiClient.dropAtCityOffice,
      mbnMap,
      contentType: 'application/x-www-form-urlencoded',
    );
    if (data.body != null && data.body is Map<String, dynamic>) {
      return APIStatus.fromJson(data.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<OrderListResponse> getPickUpCheckListForSubmitOffice(String userId) async {
    var data =
    await getMethod('${ApiClient.pickUpCheckListForSubmitOffice}=$userId');
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<OrderListResponse> getMBNListAdmin() async {
    var data = await getMethod(ApiClient.pickUpCheckList);
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<OrderListResponse> getDeliveryDriverCheckList(String userId) async {
    var data = await getMethod('${ApiClient.deliveryDriverCheckList}=$userId');
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<OrderListResponse> getCustomerInvoiceListById(String customerId) async {
    var data =
    await getMethod('${ApiClient.invoiceListByCustomerId}=$customerId');
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
        499, 499, StringConstants.errorSomethingWentWrong2, [], []);
  }

  @override
  Future<OrderListResponse> getCustomerOutstandingInvoiceListById(String customerId) async {
    var data = await getMethod(
      '${ApiClient.outstandingInvoiceListByCustomerId}=$customerId',
    );
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
      499,
      499,
      StringConstants.errorSomethingWentWrong2,
      [],
      [],
    );
  }

  @override
  Future<MessageListResponse> getCustomerMessageList(String userId) async {
    var data = await getMethod(
      '${ApiClient.messageListByCustomerId}=$userId',
    );
    return data.body is Map<String, dynamic>
        ? MessageListResponse.fromJson(data.body as Map<String, dynamic>)
        : MessageListResponse(
      499,
      499,
      StringConstants.errorSomethingWentWrong2,
      [],
    );
  }

  @override
  Future<APIStatus> sendCustomerMessage(String customerId, String message, String replyId) async {
    Map<String, dynamic> map = {};

    map['customer_id'] = customerId;
    map['message_text'] = message.trim();
    if (replyId.isNotEmpty) {
      map['reply_id'] = replyId.trim();
    }
    var data = await postMethod(
      ApiClient.sendCustomerMessage,
      map,
      contentType: 'application/x-www-form-urlencoded',
    );
    if (data.body != null && data.body is Map<String, dynamic>) {
      return APIStatus.fromJson(data.body as Map<String, dynamic>);
    } else {
      return APIStatus();
    }
  }

  @override
  Future<MessageListResponse> getAdminMessageList() async {
    var data = await getMethod(
      ApiClient.adminMessageList,
    );
    return data.body is Map<String, dynamic>
        ? MessageListResponse.fromJson(data.body as Map<String, dynamic>)
        : MessageListResponse(
      499,
      499,
      StringConstants.errorSomethingWentWrong2,
      [],
    );
  }

  @override
  Future<OrderStatusResponse> getOrderStatus(String mbn) async {
    var data = await getMethod(
      '${ApiClient.orderStatus}=$mbn',
    );
    return data.body is Map<String, dynamic>
        ? OrderStatusResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderStatusResponse(
      499,
      499,
      StringConstants.errorSomethingWentWrong2,
      [],
    );
  }

  @override
  Future<OrderListResponse> search(String text) async {
    var data = await getMethod(
      '${ApiClient.search}=$text',
    );
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
            499,
            499,
            StringConstants.errorSomethingWentWrong2,
            [],
            [],
          );
  }

  @override
  Future<OrderListResponse> searchHouse(String text) async {
    var data = await getMethod(
      '${ApiClient.searchHouse}=$text',
    );
    return data.body is Map<String, dynamic>
        ? OrderListResponse.fromJson(data.body as Map<String, dynamic>)
        : OrderListResponse(
            499,
            499,
            StringConstants.errorSomethingWentWrong2,
            [],
            [],
          );
  }

  @override
  Future<Response> webUploadFile(
      String mawb,
      Uint8List? imageFile,
      Uint8List? signatureFile,
      bool isPickUp,
      String driverId,
      String imageFileExtension) {
    Map<String, dynamic> formMap = {};
    if (imageFile != null) {
      formMap[isPickUp ? 'pickup_product_image' : 'delivery_product_image'] =
          MultipartFile(imageFile, filename: '${mawb}_img.$imageFileExtension');
    }
    if (signatureFile != null) {
      formMap[isPickUp
          ? 'pickup_driver_signature'
          : 'delivery_driver_signature'] =
          MultipartFile(signatureFile, filename: '${mawb}_sig.png');
    }

    if (isPickUp) {
      formMap['driverid'] = driverId;
    }
    formMap['mbn'] = mawb;
    final form = FormData(formMap);

    return postMethod(
        isPickUp ? ApiClient.uploadPickPOD : ApiClient.uploadDeliveryPOD, form);
  }

  @override
  Future<HouseListResponse> getHouseList() async {
    var data = await getMethod(ApiClient.houseList);
    return data.body is String
        ? HouseListResponse.fromJson(jsonDecode(data.body as String))
        : HouseListResponse(
            499,
            499,
            StringConstants.errorSomethingWentWrong2,
            [],
          );
  }
}
