import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:get/get.dart';

class OrderData {
  String? id;
  String? mbn;
  String? houseNumber;
  String? customerId;
  String? pickupDriver;
  String? deliveryDriver;
  String? estimateDeliveryDate;
  String? productImage;
  String? deliveryDriverSignature;
  String? deliveryDriverProduct;
  String? pickUpDriverProduct;
  String? pickUpDriverSignature;
  String? weight;
  String? length;
  String? height;
  String? recipentPersonName;
  String? orderStatus;
  String? deliverdDatetime;
  String? createdDate;
  String? statusText;
  String? assignDriverName;
  String? totalAmount;
  String? taxAmount;
  String? invoiceAmount;
  String? paymentMode;
  String? paymentStatus;
  String? paymentDate;
  String? invoiceId;
  String? assignCustomerName;
  String? pickupDriverSignatureDatetime;
  String? pickupDriverImageDatetime;
  String? deliveryDriverImageDatetime;
  String? deliveryDriverSignatureDatetime;

  OrderData(
      {this.id,
      this.mbn,
      this.houseNumber,
      this.customerId,
      this.deliveryDriver,
      this.pickupDriver,
      this.estimateDeliveryDate,
      this.productImage,
      this.deliveryDriverProduct,
      this.weight,
      this.length,
      this.height,
      this.deliveryDriverSignature,
      this.pickUpDriverProduct,
      this.pickUpDriverSignature,
      this.recipentPersonName,
      this.orderStatus,
      this.deliverdDatetime,
      this.statusText,
      this.assignDriverName,
      this.totalAmount,
      this.taxAmount,
      this.invoiceAmount,
      this.invoiceId,
      this.paymentDate,
      this.paymentMode,
      this.paymentStatus,
      this.assignCustomerName,
      this.pickupDriverImageDatetime,
      this.pickupDriverSignatureDatetime,
      this.deliveryDriverImageDatetime,
      this.deliveryDriverSignatureDatetime,
      this.createdDate});

  RxBool isExpanded = false.obs;

  bool get isAssignedToPickUpDriver =>
      int.parse((orderStatus == null || orderStatus!.isEmpty)
          ? '0'
          : orderStatus ?? '0') ==
      Constant.assignedToPickUpDriver;

  bool get isAssignedToDeliveryDriver =>
      int.parse((orderStatus == null || orderStatus!.isEmpty)
          ? '0'
          : orderStatus ?? '0') ==
      Constant.assignedToDeliveryDriver;

  bool get isDeliveryToCustomer =>
      int.parse((orderStatus == null || orderStatus!.isEmpty)
          ? '0'
          : orderStatus ?? '0') ==
      Constant.deliveryToCustomer;

  int get orderId => int.parse(
      (orderStatus == null || orderStatus!.isEmpty) ? '0' : orderStatus ?? '0');

  RxBool isSelected = false.obs;

  bool get isCheckedIn => int.parse(orderStatus ?? '0') >= 2;

  bool get hasProductImageAndSignature =>
      (pickUpDriverProduct ?? '').isNotEmpty &&
      (pickUpDriverSignature ?? '').isNotEmpty;

  bool get isPaid => paymentStatus == '1';

  bool get isOrderStatus2Or5 =>
      (int.parse(orderStatus == null || orderStatus!.isEmpty
                  ? '-1'
                  : orderStatus ?? '-1')
              .compareTo(2)) ==
          0 ||
      (int.parse(orderStatus == null || orderStatus!.isEmpty
                  ? '-1'
                  : orderStatus ?? '-1')
              .compareTo(5)) ==
          0;

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'] as String;
    mbn = json['mbn'] == null ? '' : json['mbn'] as String;
    houseNumber = json['house_no'] == null ? '' : json['house_no'] as String;
    customerId =
        json['customer_id'] == null ? '' : json['customer_id'] as String;
    deliveryDriver = json['delivery_driver'] == null
        ? ''
        : json['delivery_driver'] as String;
    pickupDriver =
        json['pickup_driver'] == null ? '' : json['pickup_driver'] as String;
    estimateDeliveryDate = json['estimate_delivery_date'] == null
        ? ''
        : json['estimate_delivery_date'] as String;
    productImage =
        json['product_image'] == null ? '' : json['product_image'] as String;
    deliveryDriverSignature = json['delivery_driver_signature'] == null
        ? ''
        : json['delivery_driver_signature'] as String;
    deliveryDriverProduct = json['delivery_product_image'] == null
        ? ''
        : json['delivery_product_image'] as String;

    pickUpDriverProduct = json['pickup_product_image'] == null
        ? ''
        : json['pickup_product_image'] as String;
    pickUpDriverSignature = json['pickup_driver_signature'] == null
        ? ''
        : json['pickup_driver_signature'] as String;

    weight = json['weight'] == null ? '' : json['weight'] as String;
    length = json['length'] == null ? '' : json['length'] as String;
    height = json['height'] == null ? '' : json['height'] as String;
    pickupDriverSignatureDatetime =
        json['pickup_driver_signature_datetime'] == null
            ? ''
            : json['pickup_driver_signature_datetime'] as String;
    pickupDriverImageDatetime = json['pickup_product_image_datetime'] == null
        ? ''
        : json['pickup_product_image_datetime'] as String;

    deliveryDriverSignatureDatetime =
        json['delivery_driver_signature_datetime'] == null
            ? ''
            : json['delivery_driver_signature_datetime'] as String;
    deliveryDriverImageDatetime =
        json['delivery_product_image_datetime'] == null
            ? ''
            : json['delivery_product_image_datetime'] as String;

    assignCustomerName = json['assigncustomername'] == null
        ? ''
        : json['assigncustomername'] as String;
    invoiceAmount =
        json['invoice_amount'] == null ? '0' : json['invoice_amount'] as String;
    totalAmount =
        json['total_amount'] == null ? '0' : json['total_amount'] as String;
    taxAmount = json['tax_amount'] == null ? '0' : json['tax_amount'] as String;
    assignDriverName = json['assigndrivername'] == null
        ? ''
        : json['assigndrivername'] as String;
    statusText =
        json['status_text'] == null ? '' : json['status_text'] as String;
    recipentPersonName = json['recipent_person_name'] == null
        ? ''
        : json['recipent_person_name'] as String;
    orderStatus =
        json['order_status'] == null ? '' : json['order_status'] as String;
    deliverdDatetime = json['deliverd_datetime'] == null
        ? ''
        : json['deliverd_datetime'] as String;
    createdDate =
        json['created_date'] == null ? '' : json['created_date'] as String;

    invoiceId = json['invoice_id'] == null ? '' : json['invoice_id'] as String;
    paymentMode =
        json['payment_mode'] == null ? '' : json['payment_mode'] as String;
    paymentStatus =
        json['payment_status'] == null ? '' : json['payment_status'] as String;
    paymentDate =
        json['payment_date'] == null ? '' : json['payment_date'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mbn'] = mbn;
    data['house_no'] = houseNumber;
    data['customer_id'] = customerId;
    data['pickup_driver'] = pickupDriver;
    data['delivery_driver'] = deliveryDriver;
    data['estimate_delivery_date'] = estimateDeliveryDate;
    data['product_image'] = productImage;
    data['delivery_driver_signature'] = deliveryDriverSignature;
    data['delivery_product_image'] = deliveryDriverProduct;
    data['pickup_product_image'] = pickUpDriverProduct;
    data['pickup_driver_signature'] = pickUpDriverSignature;
    data['weight'] = weight;
    data['length'] = length;
    data['height'] = height;
    data['status_text'] = statusText;
    data['recipent_person_name'] = recipentPersonName;
    data['order_status'] = orderStatus;
    data['deliverd_datetime'] = deliverdDatetime;
    data['created_date'] = createdDate;
    data['assigndrivername'] = assignDriverName;
    data['total_amount'] = totalAmount;
    data['tax_amount'] = taxAmount;
    data['invoice_amount'] = invoiceAmount;
    data['invoice_id'] = invoiceId;
    data['payment_mode'] = paymentMode;
    data['payment_status'] = paymentStatus;
    data['payment_date'] = paymentDate;
    data['assigncustomername'] = assignCustomerName;
    return data;
  }

  String get orderStatusInString {
    int orderStatusInt = int.parse(orderStatus ?? '0');
    switch (orderStatusInt) {
      case Constant.orderCreated:
        return 'Created';
      case Constant.assignedToPickUpDriver:
        return 'Assigned -> Pickup Driver';
      case Constant.pickUpThroughPickUpDriver:
        return 'Order pickUp by Pickup Driver';
      case Constant.dropAtWareHouse:
        return 'Delivered -> In Bronco Distribution Center';
      case Constant.assignedToDeliveryDriver:
        return 'Assigned -> Delivery Driver';
      case Constant.pickUpThroughDeliveryDriver:
        return 'Order pickUp by Delivery Driver';
      case Constant.deliveryToCustomer:
        return 'Delivered to customer';
    }
    return '-';
  }
}
