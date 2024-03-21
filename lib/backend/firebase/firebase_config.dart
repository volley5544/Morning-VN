import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC24Qodd1-AWS34knUKBC2A9FJu7mpukTA",
            authDomain: "arunsawad-vn-application.firebaseapp.com",
            projectId: "arunsawad-vn-application",
            storageBucket: "arunsawad-vn-application.appspot.com",
            messagingSenderId: "171972195219",
            appId: "1:171972195219:web:9f4b5d212795fcbe156e66",
            measurementId: "G-YNZS25RZF1"));
  } else {
    await Firebase.initializeApp();
  }
}
