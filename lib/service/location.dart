import 'package:geolocator/geolocator.dart';

class Location {

  double long;
  double lat;

  Future<void> getLocation() async {
    //TODO: Error Handling! If permission is not granted, send alert
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    } catch (e) {
      position = null;
    }

    if (position != null) {
      long = position.longitude;
      lat = position.latitude;
    }
  }
}
