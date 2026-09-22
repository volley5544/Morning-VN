import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBljrSuINSa7Py-RL-i4RyCfDWS4O_SRms",
            authDomain: "arunsawad-vn-project.firebaseapp.com",
            projectId: "arunsawad-vn-project",
            storageBucket: "arunsawad-vn-project.appspot.com",
            messagingSenderId: "429713224818",
            appId: "1:429713224818:web:e3a32a0ebc5698fb7afeeb"));
  } else {
    await Firebase.initializeApp();
  }
}
