// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

Future periodicGetLocation(String? username, String? phoneNumber,
    String? operatingSystem, String? deviceId) async {
  // Add your function code here!
  Timer.periodic(const Duration(minutes: 1), (timer) {
    if (!(FFAppState().isLoginNew)) ;
    {
      timer.cancel();
    }
    getBackgroundLocation(username!, phoneNumber!, operatingSystem!, deviceId);
  });
}
