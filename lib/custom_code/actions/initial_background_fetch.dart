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

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/scheduler.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool _enabled = true;
int _status = 0;
List<String> _events = [];

Future initialBackgroundFetch(String? username, String? phoneNumber,
    String? operatingSystem, String? deviceId) async {
  // Add your function code here!
  String latlng = '';

  // await backgroundLocationPermission(false);
  try {
    final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

    print('BG location: ${position.latitude}, ${position.longitude}');

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        'location': GeoPoint(position.latitude, position.longitude),
        'employee_id': username!,
        'date_time': Timestamp.now(),
        'phone_number': phoneNumber!,
        'device_id': deviceId!,
        'operating_system': operatingSystem!
      };
      // await firestore.collection('UserLocationLog').add(data);
      await firestore
          .collection('UserLocationLog')
          .doc('${Timestamp.now().microsecondsSinceEpoch}')
          .set(data);
    } catch (e) {
      print('Error creating document: $e');
    }

    initPlatformState(username!, phoneNumber!, operatingSystem!, deviceId!);
  } catch (e) {
    print('ระเบิด');
    print('${e.toString()}');
  }
}

Future<bool> backgroundLocationPermission(bool? isIOS) async {
  // Add your function code here!
  bool output = false;
  var status = await Permission.locationWhenInUse.status;
  if (!status.isGranted) {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      var status = await Permission.locationAlways.request();
      if (isIOS!) {
        await Future.delayed(Duration(seconds: 10)); // Allow iOS to catch up
      }
      if (status.isGranted) {
        //Do some stuff
        output = status.isGranted;
      } else {
        //Do another stuff
        output = status.isGranted;
      }
    } else {
      //The user deny the permission
      output = false;
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
      if (isIOS!) {
        await Future.delayed(Duration(seconds: 10)); // Allow iOS to catch up
      }
      if (status.isGranted) {
        //Do some stuff
        output = status.isGranted;
      } else {
        //Do another stuff
        output = status.isGranted;
      }
    } else {
      //previously available, do some stuff or nothing
      output = true;
    }
  }
  print(output);
  return output;
}

// [Android-only] This "Headless Task" is run when the Android app is terminated with `enableHeadless: true`
// Be sure to annotate your callback function to avoid issues in release mode on Flutter >= 3.3.0
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print('[BackgroundFetch] Headless event received.');
  final position = await Geolocator.getCurrentPosition();
  print('[Headless] ${position.latitude}, ${position.longitude}');
  // Do your work here...
  BackgroundFetch.finish(taskId);
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> initPlatformState(String? username, String? phoneNumber,
    String? operatingSystem, String? deviceId) async {
  // Configure BackgroundFetch.
  int status = await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ), (String taskId) async {
    // <-- Event handler
    // This is the fetch-event callback.
    print("[BackgroundFetch] Event received $taskId");
    String location5544 = await _onBackgroundFetch(
        taskId, username!, phoneNumber!, operatingSystem!, deviceId!);

    // _events.insert(0, '${new DateTime.now()}\n${location5544}');

    // IMPORTANT:  You must signal completion of your task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }, (String taskId) async {
    // <-- Task timeout handler.
    // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
    BackgroundFetch.finish(taskId);
  });
  print('[BackgroundFetch] configure success: $status');

  _status = status;

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  // if (!mounted) return;
}

void _onClickEnable(enabled) {
  _enabled = enabled;

  if (enabled) {
    BackgroundFetch.start().then((int status) {
      print('[BackgroundFetch] start success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] start FAILURE: $e');
    });
  } else {
    BackgroundFetch.stop().then((int status) {
      print('[BackgroundFetch] stop success: $status');
    });
  }
}

void _onClickStatus() async {
  int status = await BackgroundFetch.status;
  print('[BackgroundFetch] status: $status');

  _status = status;
}

Future _onBackgroundFetch(String taskId, String? username, String? phoneNumber,
    String? operatingSystem, String? deviceId) async {
  try {
    final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));

    print('BG location: ${position.latitude}, ${position.longitude}');

    // send to server here
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> data = {
      'location': GeoPoint(position.latitude, position.longitude),
      'employee_id': username!,
      'date_time': Timestamp.now(),
      'phone_number': phoneNumber!,
      'device_id': deviceId!,
      'operating_system': operatingSystem!
    };
    // await firestore.collection('UserLocationLog').add(data);
    await firestore
        .collection('UserLocationLog')
        .doc('${Timestamp.now().microsecondsSinceEpoch}')
        .set(data);
  } catch (e) {
    print('Location error: $e');
  }

  BackgroundFetch.finish(taskId);
}
