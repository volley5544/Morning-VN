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

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> translateLanguage2(
  String text,
  String languageCode,
) async {
  // Return empty if inputs are invalid
  if (text.trim().isEmpty) return '';
  if (languageCode.trim().isEmpty) return '';

  final uri = Uri.parse(
    'https://translate.googleapis.com/translate_a/single',
  ).replace(queryParameters: {
    'client': 'gtx',
    'sl': 'auto', // auto-detect source language
    'tl': languageCode.trim().toLowerCase(), // target language e.g. th, en, vi
    'dt': 't',
    'q': text.trim(),
  });

  try {
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      return 'Error: HTTP ${response.statusCode}';
    }

    final decoded = json.decode(response.body) as List<dynamic>;
    final buffer = StringBuffer();

    for (final segment in decoded[0] as List<dynamic>) {
      if (segment[0] != null) buffer.write(segment[0]);
    }

    return buffer.toString();
  } catch (e) {
    return 'Translation failed: $e';
  }
}
