// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:permission_handler/permission_handler.dart';

Future<bool> backgroundLocationPermission() async {
  // Add your function code here!
  var status = await Permission.locationWhenInUse.status;
  if (!status.isGranted) {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      var status = await Permission.locationAlways.request();
      if (status.isGranted) {
        //Do some stuff
      } else {
        //Do another stuff
      }
    } else {
      //The user deny the permission
    }
    if (status.isPermanentlyDenied) {
      //When the user previously rejected the permission and select never ask again
      //Open the screen of settings
      bool res = await openAppSettings();
    }
  } else {
    //In use is available, check the always in use
    var status = await Permission.locationAlways.status;
    if (!status.isGranted) {
      var status = await Permission.locationAlways.request();
      if (status.isGranted) {
        //Do some stuff
      } else {
        //Do another stuff
      }
    } else {
      //previously available, do some stuff or nothing
    }
  }
  return status.isGranted;
}
