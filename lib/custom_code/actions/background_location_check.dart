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

Future<bool> backgroundLocationCheck() async {
  // Add your function code here!
  bool output = false;
  var status = await Permission.locationAlways.status;
  if (!status.isGranted) {
    output = status.isGranted;
  } else {
    output = status.isGranted;
  }
  print(output);
  return output;
}
