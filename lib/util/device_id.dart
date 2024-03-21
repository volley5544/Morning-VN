import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';
import 'package:flutter/services.dart';

var deviceId;

Future<String?> _getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final _androidIdPlugin = AndroidId();

      return (await _androidIdPlugin.getId() ?? '-');
    } on PlatformException {
      return '-';
    }
    // var androidDeviceInfo = await deviceInfo.androidInfo;
    // return androidDeviceInfo.id; // unique ID on Android
  } else
    return '-';
}

Future<String?> getId() async {
  if (deviceId == null) {
    var value = await _getId();
    deviceId = value;
    return value;
  } else {
    return deviceId;
  }
}
