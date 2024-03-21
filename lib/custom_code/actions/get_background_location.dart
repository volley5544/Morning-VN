// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:background_location/background_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future getBackgroundLocation(String? username) async {
  // Add your function code here!
  LatLng outputLocation = LatLng(0, 0);
  await BackgroundLocation.startLocationService();
  await BackgroundLocation().getCurrentLocation().then((location) async {
    print('${location.latitude}');
    outputLocation = LatLng(location.latitude!, location.longitude!);
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        'location': GeoPoint(outputLocation.latitude, outputLocation.longitude),
        'employee_id': username!,
        'date_time': Timestamp.now(),
      };
      await firestore.collection('UserLocationLog').add(data);
    } catch (e) {
      print('Error creating document: $e');
    }
  });
}
