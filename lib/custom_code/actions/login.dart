// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

Future login() async {
  // Add your function code here!
  try {
    final result = await LineSDK.instance.login();
    // setState(() {
    //   _userProfile = result.userProfile;
    // user id -> result.userProfile?.userId
    // user name -> result.userProfile?.displayName
    // user avatar -> result.userProfile?.pictureUrl
    // etc...
    // });
  } on PlatformException catch (e) {
    // Error handling.
    print(e);
  }
}
