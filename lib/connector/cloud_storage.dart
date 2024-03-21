// import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:path/path.dart';
export 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart'
    show FirebaseException;
import 'package:firebase_storage/firebase_storage.dart';

/// Ref upload data :  https://firebase.google.com/docs/storage/flutter/upload-files
///     download data: https://firebase.google.com/docs/storage/flutter/download-files
class StorageConnector {
  late String bucketPath;
  final storage = FirebaseStorage.instance;
  final downloadRef = FirebaseStorage.instance.ref();

  Reference buildRef(String filePath, String fileName) {
    return storage.ref(filePath).child(fileName);
  }

  /// File file = File('path');
  /// final ref = storageClient.uploadFile(file, destination, fileName);
  uploadBase64Image(String content, String gcsFilePath, String gcsFileName,
      {String contentType = "image/jpeg"}) async {
    logger.e('uploadBase64Image file is called');
    try {
      final ref = buildRef(gcsFilePath, gcsFileName);
      await ref.putString(
        content,
      );
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      logger.e('this uploadFile error: $e');
    }
  }

  uploadFile(File content, String gcsFilePath, String gcsFileName,
      {String contentType = "image/jpeg"}) async {
    logger.e('upload file is called');
    try {
      final ref = buildRef(gcsFilePath, gcsFileName);
      await ref.putFile(
          content,
          SettableMetadata(
            contentType: contentType,
          ));
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      logger.e('this uploadFile error: $e');
    }
  }

  uploadString(String content, String gcsFilePath, String gcsFileName) async {
    try {
      final ref = buildRef(gcsFilePath, gcsFileName);
      await ref.putString(content, format: PutStringFormat.dataUrl);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      logger.e('this uploadString error : $e');
    }
  }

  uploadRawData(
      Uint8List content, String gcsFilePath, String gcsFileName) async {
    try {
      final ref = buildRef(gcsFilePath, gcsFileName);
      await ref.putData(content);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      logger.e('this uploadRawData error : $e');
    }
  }

  getDownloadRef(String path, Reference ref) {
    if (path.contains('gs://')) {
      return FirebaseStorage.instance.refFromURL(path);
    } else {
      return ref.child(path);
    }
  }

  isFileExists(String path) async {
    try {
      await downloadRef.child(path).getDownloadURL();
      return true;
    } catch (error) {
      logger.e('file not found : $error');
      return false;
    }
  }

  downloadToMemory(String path) async {
    Reference ref = await getDownloadRef(path, downloadRef);
    // bool fileExist = await isFileExists(path);
    // if (!fileExist) { do something};
    try {
      // const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await ref.getData();
      // Data for "images/island.jpg" is returned, use this as needed.
      return data;
    } catch (e) {
      logger.e('downloadFileToMemory error : $e');
    }
  }

  downloadToFile(String gcsPath, String localPath) async {
    final ref = getDownloadRef(gcsPath, downloadRef);
    final localFilePath = File(localPath);

    final downloadTask = ref.writeToFile(localFilePath);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          logger.i('running');
          // TODO: Handle this case.
          break;
        case TaskState.paused:
          logger.i('paused');
          // TODO: Handle this case.
          break;
        case TaskState.success:
          logger.i('success');
          // TODO: Handle this case.
          break;
        case TaskState.canceled:
          logger.i('canceled');
          // TODO: Handle this case.
          break;
        case TaskState.error:
          logger.i('error');
          // TODO: Handle this case.
          break;
      }
    });
  }
}
