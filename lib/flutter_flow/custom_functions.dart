import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

bool? checkPin(String? input) {
  if (input!.length != 6) {
    return false;
  } else {
    if (int.tryParse(input!) != null) {
      return true;
    } else {
      return false;
    }
  }
}

String? getBuildNumber(String? buildVersion) {
  // Find the index of the opening parenthesis
  int startIndex = buildVersion!.indexOf('(');

  // Find the index of the closing parenthesis
  int endIndex = buildVersion!.indexOf(')');

  // Extract the substring between the parentheses
  String numberString = buildVersion!.substring(startIndex + 1, endIndex);

  // Convert the extracted substring to an integer

  print(numberString); // Output: 21

  return numberString;
}
