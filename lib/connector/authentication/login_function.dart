import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

class LoginFunction {
  static Future<String> signIn(result, [BuildContext? context]) async {
    await FirebaseAuth.instance.signInWithCustomToken(result);
    var fireBaseToken =
        await FirebaseAuth.instance.currentUser!.getIdToken(true);
    return fireBaseToken;
  }

  static Future signOut([BuildContext? context]) async {
    await FirebaseAuth.instance.signOut();
  }

  static Future checkIfUserExists(String thaiId, bool isHash) async {
    try {
      var output =
          isHash ? thaiId : sha256.convert(utf8.encode(thaiId)).toString();
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection('users');
      var doc = await collectionRef.doc(output).get();
      return doc.exists;
    } catch (e) {
      logger.e('CheckIfUserExists Error ${e}');
      return false;
    }
  }
}
