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
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Future periodicGetLocation(String? username, String? phoneNumber,
    String? operatingSystem, String? deviceId) async {
  // Add your function code here!
  bool checker = true;
  Timer? mainTimer2;

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    print('in 5 sexc');
    if (checker) {
      checker = false;
      mainTimer2 = Timer.periodic(const Duration(minutes: 15), (timer2) async {
        bool result = await InternetConnection().hasInternetAccess;
        print('internet connectionnn : ${result}');
        if (result) {
          getBackgroundLocation(
              username!, phoneNumber!, operatingSystem!, deviceId);
        }
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
