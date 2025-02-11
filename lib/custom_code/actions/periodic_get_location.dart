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
  bool checker = true;
  Timer? mainTimer2;

  Timer.periodic(const Duration(seconds: 5), (timer) {
    print('in 5 sexc');
    if (checker) {
      checker = false;
      mainTimer2 = Timer.periodic(const Duration(seconds: 30), (timer2) {
        getBackgroundLocation(
            username!, phoneNumber!, operatingSystem!, deviceId);
        print('FFAppState().isLoginNew : ${FFAppState().isLoginNew}');
        checker = true;
        if (mainTimer2 != null) {
          mainTimer2?.cancel();
          mainTimer2 = null;
        }
      });
    }

    if (!(FFAppState().isLoginNew)) {
      print('timeer Cancel');
      timer.cancel();
      mainTimer2?.cancel();
      mainTimer2 = null;
    }
  });
}
