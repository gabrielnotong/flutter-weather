import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double long;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      lat = position.latitude;
      long = position.longitude;
    } catch (e) {
      lat = 0.0;
      long = 0.0;
    }
  }
}
