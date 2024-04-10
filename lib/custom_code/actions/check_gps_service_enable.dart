// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:geolocator/geolocator.dart';

Future<bool> checkGpsServiceEnable() async {
  // Add your function code here!
  bool serviceEnabled;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  print('isServiceEnable : $serviceEnabled');
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    print(Future.error('Location services are disabled.'));
  }
  return serviceEnabled;
}
