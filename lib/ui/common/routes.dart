import 'package:bronco_trucking/ui/authentication/forgot_pass/forgot_binding.dart';
import 'package:bronco_trucking/ui/authentication/forgot_pass/forgot_pass_page.dart';
import 'package:bronco_trucking/ui/authentication/login/login_binding.dart';
import 'package:bronco_trucking/ui/authentication/login/login_page.dart';
import 'package:bronco_trucking/ui/authentication/registration/registration_binding.dart';
import 'package:bronco_trucking/ui/authentication/registration/registration_page.dart';
import 'package:bronco_trucking/ui/common/page_fade_transitions.dart';
import 'package:bronco_trucking/ui/dashboard/add_digital_signature/add_digital_signature_binding.dart';
import 'package:bronco_trucking/ui/dashboard/add_digital_signature/add_digital_signature_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_billable_weight/billable_weigh/billable_weight_list_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_billable_weight/billable_weigh/billable_weight_list_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/add_customer/add_customer_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/add_customer/add_customer_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/add_driver/add_driver_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/add_driver/add_driver_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/enter_mawb/enter_mawb_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/enter_mawb/enter_mawb_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/select_customer/select_customer_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/add_shipment/select_customer/select_customer_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/admin_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/admin_dashboard_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/assign_driver/select_driver/select_driver_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/assign_driver/select_driver/select_driver_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/admin_check_in_list_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/admin_check_in_list_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/check_in_list_detail/check_in_list_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/check_in_list/check_in_list_detail/check_in_list_detail_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/invoices/invoice_list_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/invoices/invoice_list_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/messages/admin_message_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/messages/admin_message_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/search/search_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/search/search_page.dart';
import 'package:bronco_trucking/ui/dashboard/admin/select_mawb/select_mawb_binding.dart';
import 'package:bronco_trucking/ui/dashboard/admin/select_mawb/select_mawb_page.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_binding.dart';
import 'package:bronco_trucking/ui/dashboard/customer/customer_dashboard_page.dart';
import 'package:bronco_trucking/ui/dashboard/customer/invoice_detail/invoice_detail_binding.dart';
import 'package:bronco_trucking/ui/dashboard/customer/invoice_detail/invoice_detail_page.dart';
import 'package:bronco_trucking/ui/dashboard/customer/invoice_payment_detail/invoice_payment_detail_binding.dart';
import 'package:bronco_trucking/ui/dashboard/customer/invoice_payment_detail/invoice_payment_detail_page.dart';
import 'package:bronco_trucking/ui/dashboard/customer/package_detail/package_detail_binding.dart';
import 'package:bronco_trucking/ui/dashboard/customer/package_detail/package_detail_page.dart';
import 'package:bronco_trucking/ui/dashboard/customer/select_mawb_payment/select_mawb_payment_binding.dart';
import 'package:bronco_trucking/ui/dashboard/customer/select_mawb_payment/select_mawb_payment_page.dart';
import 'package:bronco_trucking/ui/dashboard/driver/check_in_list/check_in_list_binding.dart';
import 'package:bronco_trucking/ui/dashboard/driver/check_in_list/check_in_list_page.dart';
import 'package:bronco_trucking/ui/dashboard/driver/driver_binding.dart';
import 'package:bronco_trucking/ui/dashboard/driver/driver_dashboard_page.dart';
import 'package:bronco_trucking/ui/dashboard/driver/submit_to_office/submit_to_office_binding.dart';
import 'package:bronco_trucking/ui/dashboard/driver/submit_to_office/submit_to_office_page.dart';
import 'package:bronco_trucking/ui/dashboard/order_status/order_status_binding.dart';
import 'package:bronco_trucking/ui/dashboard/order_status/order_status_page.dart';
import 'package:bronco_trucking/ui/dashboard/payment/payment_binding.dart';
import 'package:bronco_trucking/ui/dashboard/payment/payment_page.dart';
import 'package:bronco_trucking/ui/dashboard/pod/pod_binding.dart';
import 'package:bronco_trucking/ui/dashboard/pod/pod_page.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/success_error_binding.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/success_error_page.dart';
import 'package:bronco_trucking/ui/dashboard/upload_pod/upload_pod_and_signature_binding.dart';
import 'package:bronco_trucking/ui/dashboard/upload_pod/upload_pod_and_signature_page.dart';
import 'package:bronco_trucking/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteName {
  // Base routes
  static const String root = '/';
  static const String profilePage = '/profile';
  static const String loginPage = '/login';
  static const String registrationPage = '/registration';
  static const String forgotPage = '/forgot_pass';
  static const String adminDashboardPage = '/adminDashboard';
  static const String customerDashboardPage = '/customerDashboard';
  static const String driveDashboardPage = '/driveDashboard';
  static const String paymentPage = '/payment';
  static const String podPage = '/pod';
  static const String invoiceDetail = '/invoiceDetailPage';
  static const String checkInList = '/checkInListPage';
  static const String uploadPOD = '/uploadPODAndSignaturePage';
  static const String addDigitalSignature = '/addDigitalSignaturePage';
  static const String enterMAWBNumber = '/enterMAWBPage';
  static const String selectCustomer = '/selectCustomerPage';
  static const String addCustomer = '/addCustomerPage';
  static const String addDriver = '/addDriverPage';
  static const String adminCheckInList = '/adminCheckInListPage';
  static const String adminInvoiceList = '/adminInvoiceListPage';
  static const String adminSelectMAWB = '/adminSelectMAWBPage';
  static const String adminSelectDriver = '/adminSelectDriver';
  static const String adminBillableWeight = '/adminBillableWeight';
  static const String successError = '/successError';
  static const String orderStatus = '/orderStatusPage';
  static const String packageDetail = '/packageDetailPage';
  static const String submitToOffice = '/submitToOfficePage';
  static const String adminMessages = '/adminMessages';
  static const String selectMAWBPayment = '/selectMAWBPayment';
  static const String invoicePaymentDetail = '/invoicePaymentDetail';
  static const String checkInListDetail = '/checkInListDetail';
  static const String search = '/search';
}

class Routes {
  static final commonRoutes = <String, WidgetBuilder>{};

  static final routes = [
    GetPage(
      page: () => LoginPage(),
      binding: LoginBinding(),
      customTransition: PageFadeTransitions(),
      transitionDuration: const Duration(milliseconds: 500),
      name: RouteName.loginPage,
    ),
    GetPage(
      page: () => ForgotPasswordPage(),
      binding: ForgotBinding(),
      name: RouteName.forgotPage,
    ),
    GetPage(
      page: () => RegistrationPage(),
      binding: RegistrationBinding(),
      name: RouteName.registrationPage,
    ),
    GetPage(
      page: () => SplashPage(),
      name: RouteName.root,
    ),
    GetPage(
      page: () => AdminDashboardPage(),
      binding: AdminBinding(),
      customTransition: PageFadeTransitions(),
      transitionDuration: const Duration(milliseconds: 1000),
      name: RouteName.adminDashboardPage,
    ),
    GetPage(
      page: () => CustomerDashboardPage(),
      binding: CustomerBinding(),
      customTransition: PageFadeTransitions(),
      transitionDuration: const Duration(milliseconds: 1000),
      name: RouteName.customerDashboardPage,
    ),
    GetPage(
      page: () => PaymentPage(),
      binding: PaymentBinding(),
      name: RouteName.paymentPage,
    ),
    GetPage(
      page: () => PODPage(),
      binding: PODBinding(),
      name: RouteName.podPage,
    ),
    GetPage(
      page: () => DriverDashboardPage(),
      binding: DriverBinding(),
      customTransition: PageFadeTransitions(),
      transitionDuration: const Duration(milliseconds: 800),
      name: RouteName.driveDashboardPage,
    ),
    GetPage(
      page: () => InvoiceDetailPage(),
      binding: InvoiceDetailBinding(),
      name: RouteName.invoiceDetail,
    ),
    GetPage(
      page: () => CheckInListPage(),
      binding: CheckInListBinding(),
      name: RouteName.checkInList,
    ),
    GetPage(
      page: () => UploadPODAndSignaturePage(),
      binding: UploadPODAndSignatureBinding(),
      name: RouteName.uploadPOD,
    ),
    GetPage(
      page: () => AddDigitalSignaturePage(),
      binding: AddDigitalSignatureBinding(),
      name: RouteName.addDigitalSignature,
    ),
    GetPage(
      page: () => EnterMAWBPage(),
      binding: EnterMAWBBinding(),
      name: RouteName.enterMAWBNumber,
    ),
    GetPage(
      page: () => SelectCustomerPage(),
      binding: SelectCustomerBinding(),
      name: RouteName.selectCustomer,
    ),
    GetPage(
      page: () => AddCustomerPage(),
      binding: AddCustomerBinding(),
      name: RouteName.addCustomer,
    ),
    GetPage(
      page: () => AdminCheckInListPage(),
      binding: AdminCheckInListBinding(),
      name: RouteName.adminCheckInList,
    ),
    GetPage(
      page: () => InvoiceListPage(),
      binding: InvoiceListBinding(),
      name: RouteName.adminInvoiceList,
    ),
    GetPage(
      page: () => SelectMAWBPage(),
      binding: SelectMAWBBinding(),
      name: RouteName.adminSelectMAWB,
    ),
    GetPage(
      page: () => SelectDriverPage(),
      binding: SelectDriverBinding(),
      name: RouteName.adminSelectDriver,
    ),
    GetPage(
      page: () => AddDriverPage(),
      binding: AddDriverBinding(),
      name: RouteName.addDriver,
    ),
    GetPage(
      page: () => BillableWeightListPage(),
      binding: BillableWeightListBinding(),
      name: RouteName.adminBillableWeight,
    ),
    GetPage(
      page: () => OrderStatusPage(),
      binding: OrderStatusBinding(),
      name: RouteName.orderStatus,
    ),
    GetPage(
      page: () => SuccessErrorMessage(),
      name: RouteName.successError,
      binding: SuccessErrorBinding(),
    ),
    GetPage(
      page: () => PackageDetailPage(),
      name: RouteName.packageDetail,
      binding: PackageDetailBinding(),
    ),
    GetPage(
        page: () => SubmitToOfficePage(),
        name: RouteName.submitToOffice,
        binding: SubmitToOfficeBinding()),
    GetPage(
        page: () => AdminMessagePage(),
        name: RouteName.adminMessages,
        binding: AdminMessageBinding()),
    GetPage(
        page: () => SelectMAWBPaymentPage(),
        name: RouteName.selectMAWBPayment,
        binding: SelectMAWBPaymentBinding()),
    GetPage(
        page: () => InvoicePaymentDetailPage(),
        name: RouteName.invoicePaymentDetail,
        binding: InvoicePaymentDetailBinding()),
    GetPage(
        page: () => SearchPage(),
        name: RouteName.search,
        binding: SearchBinding()),
    GetPage(
        page: () => CheckInListDetailPage(),
        name: RouteName.checkInListDetail,
        binding: CheckInListDetailBinding()),
  ];
}
