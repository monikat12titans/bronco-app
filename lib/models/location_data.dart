import 'package:geolocator/geolocator.dart';

class LocationData {
  bool status;
  String message;
  Position? position;
  int errorCode;

  LocationData(this.status, this.message, this.position, this.errorCode);
}
