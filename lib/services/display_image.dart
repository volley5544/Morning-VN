import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';

import '../util/logger_service.dart';

class Displayimage {
  StorageConnector storageConnector = StorageConnector();
  Future<void> uploadDisplayImage(File _photo) async {
    try {
      var user = await FirebaseAuth.instance.currentUser;
      await user!.getIdTokenResult();
      String userId = user.uid;
      final gcsPath = '/users/$userId';

      //upload image to fire store
      await storageConnector.uploadFile(_photo, gcsPath, 'display_image.jpg');

      // Update firestore
      String gcsFilePage = '$gcsPath/display_image.jpg';
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users
          .doc(userId)
          .collection('profile')
          .doc(userId)
          .update({'display_image': gcsFilePage});
    } catch (e) {
      logger.e('error in uploading image :e');
    }
  }
}
