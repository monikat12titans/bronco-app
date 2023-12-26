import 'package:get/get.dart';

class PaymentController extends GetxController {
  String paymentMethodId = '';
  String errorMessage = '';
 /* var stripePayment = FlutterStripePayment();
  var isNativePayAvailable = false;
*/
  @override
  void onInit() {
    super.onInit();
    /*stripePayment.setStripeSettings(
      Constant.stripeId,
    );
    stripePayment.onCancel = () {
      print('the payment form was cancelled');
    };*/
  }

  Future<void> onTap() async {
   /* var paymentItem = PaymentItem(label: 'Air Jordan Kicks', amount: 249.99);
    var taxItem = PaymentItem(label: 'NY Sales Tax', amount: 21.87);
    var shippingItem = PaymentItem(label: 'Shipping', amount: 5.99);
    var stripeToken = await stripePayment.getPaymentMethodFromNativePay(
        countryCode: 'US',
        currencyCode: 'USD',
        paymentNetworks: [
          PaymentNetwork.visa,
          PaymentNetwork.mastercard,
          PaymentNetwork.amex,
          PaymentNetwork.discover
        ],
        merchantName: 'Nike Inc.',
        paymentItems: [paymentItem, shippingItem, taxItem]);*/
  }
}
