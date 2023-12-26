class CheckInData {
  final String id;
  final String? delivered;
  final bool isCheckedIn;

  CheckInData({this.isCheckedIn = false, this.id = '-1', this.delivered});
}
