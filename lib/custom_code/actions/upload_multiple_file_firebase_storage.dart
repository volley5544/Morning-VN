// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:typed_data';
import 'package:flutter/services.dart';
import '/backend/firebase_storage/storage.dart'; // Imports firebase storage function

Future<List<String>?> uploadMultipleFileFirebaseStorage(
  BuildContext context,
  String? uploadedFolderName,
  List<FFUploadedFile>? file,
  Future Function(String? statusMessage)? updateStatusProcessAction,
) async {
  // Add your function code here!
  //DateFormat dateFormat = DateFormat("yyyy-MM-dd-HH:mm:ss"); //yyyyMMddHHmmssSSS
  //String timestamp = dateFormat.format(DateTime.now());
  List<String> fileUrlOutputList = [];

  DateFormat dateFormat1 = DateFormat("yyyyMMM"); //yyyyMMddHHmmssSSS
  String folderName = dateFormat1.format(DateTime.now());
  for (int i = 0; i < file!.length; i++) {
    if (i < 5) {
      await updateStatusProcessAction!(
          FFLocalizations.of(context).languageCode == 'th'
              ? 'กำลังอัปโหลดรูปภาพ ${i + 1}/${file!.length}'
              : FFLocalizations.of(context).languageCode == 'en'
                  ? 'Uploading Image ${i + 1}/${file!.length}'
                  : FFLocalizations.of(context).languageCode == 'vi'
                      ? 'Đang tải ảnh lên ${i + 1}/${file!.length}'
                      : 'กำลังอัปโหลดรูปภาพ ${i + 1}/${file!.length}');

      String uniqueFileName = '${file![i].name!}'; //fileName + " " + timestamp;

      String pathUploaded =
          '${uploadedFolderName!}/${folderName}/${uniqueFileName}'; //uploadedFolderName! + "/" + folderName + "/" + uniqueFileName;
      String? fileUrlOutput = await uploadData(pathUploaded, file![i].bytes!);
      fileUrlOutputList.add(fileUrlOutput!);
    }
  }
  return fileUrlOutputList;
  // Add your function code here!
}
