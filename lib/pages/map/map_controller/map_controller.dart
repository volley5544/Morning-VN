import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/pages/map/google_map_value_handler.dart';

double parsingDouble(String value) {
  try {
    return double.parse(value);
  } catch (e) {
    return 0.0;
  }
}

void updateCameraLocation(
  LatLng source,
  LatLng destination,
  GoogleMapController mapController,
) {
  if (mapController == null) return;

  LatLngBounds bounds;

  if (source.latitude > destination.latitude &&
      source.longitude > destination.longitude) {
    bounds = LatLngBounds(southwest: destination, northeast: source);
  } else if (source.longitude > destination.longitude) {
    bounds = LatLngBounds(
        southwest: LatLng(source.latitude, destination.longitude),
        northeast: LatLng(destination.latitude, source.longitude));
  } else if (source.latitude > destination.latitude) {
    bounds = LatLngBounds(
        southwest: LatLng(destination.latitude, source.longitude),
        northeast: LatLng(source.latitude, destination.longitude));
  } else {
    bounds = LatLngBounds(southwest: source, northeast: destination);
  }

  CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

  return checkCameraLocation(cameraUpdate, mapController);
}

void checkCameraLocation(
    CameraUpdate cameraUpdate, GoogleMapController mapController) async {
  mapController.animateCamera(cameraUpdate);
  LatLngBounds l1 = await mapController.getVisibleRegion();
  LatLngBounds l2 = await mapController.getVisibleRegion();

  if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
    return checkCameraLocation(cameraUpdate, mapController);
  }
}

String getBranchDistance(BranchDetail branch, Position devicePosition) {
  GoogleMapValueHandler googleMapService = GoogleMapValueHandler();
  double distance = googleMapService.haversineDistance(
      double.tryParse(branch.latitude) ?? 0,
      double.tryParse(branch.longtitude) ?? 0,
      devicePosition.latitude,
      devicePosition.longitude);
  return distance.toStringAsFixed(1);
}
