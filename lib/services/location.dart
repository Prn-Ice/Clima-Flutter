//The Location class returns our devices longitude and latitude
// using the geoLocator package, we had to obtain permissions from
// the device first

import 'package:geolocator/geolocator.dart';

import '../utilities/constants.dart';

class Location {
  double longitude;
  double latitude;

//  The getCurrentLocation() sets the values of latitude and longitude
//  to the devices current location using the geoLocator package
//  It also returns a default value of 0.0 if the location cant be during
//  a specified duration

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .timeout(kLocationTimeOut)
        .catchError((e) {
      print(e);
    });
    if (position != null) {
      longitude = position.longitude;
      latitude = position.latitude;
    } else {
      longitude = latitude = 0.0;
    }
  }
}
