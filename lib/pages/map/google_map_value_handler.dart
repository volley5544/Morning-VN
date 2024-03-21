import 'dart:math' as math;

import 'package:geolocator/geolocator.dart';

enum LocationPermissionError{
  serviceNotAvailable,
  permissionDenied,
  permissionDeniedForever,
}
class GoogleMapValueHandler {
  double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(double value) {
    return value * math.pi / 180;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(LocationPermissionError.serviceNotAvailable);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(LocationPermissionError.permissionDenied);
      }else if (permission == LocationPermission.deniedForever) {
        return Future.error(LocationPermissionError.permissionDeniedForever);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(LocationPermissionError.permissionDeniedForever);
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> isLocationAvailable() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(LocationPermissionError.serviceNotAvailable);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(LocationPermissionError.permissionDenied);
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(LocationPermissionError.permissionDeniedForever);
    }
    return true;
  }
}
