class PackageData {
  final String id;
  final String packageId;
  final bool isCheckedIn;
  final int? checkInTime;
  final String? deliveredAddress;
  final int? deliveredTime;
  final bool isInvoiceSent;
  final bool isDelivered;
  final int? paymentStatus;

  /// 0 - pending 1- completed
  final int? paymentTime;

  PackageData(this.id,
      this.packageId,
      this.checkInTime,
      this.deliveredAddress,
      this.deliveredTime,
      this.paymentStatus,
      this.paymentTime, {
        this.isCheckedIn = false,
        this.isDelivered = false,
        this.isInvoiceSent = false,
      });
}
