import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_application_srisawad/models/notify_model.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

class NotifyConnector {
  NotifyConnector._privateConstructor();

  static final NotifyConnector _instance =
      NotifyConnector._privateConstructor();

  static NotifyConnector get instance => _instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String userId = '';
  CollectionReference? notifyInstance;

  NotifyConnector(String userId) {
    this.userId = userId;
    final tmp = this.firestore;
    this.notifyInstance = tmp
        .collection('users')
        .withConverter<FirestoreNotifyModel>(
            fromFirestore: (snapshot, _) =>
                FirestoreNotifyModel.fromJson(snapshot.data()!),
            toFirestore: (_notify, _) {
              return _notify.toJson();
            });
  }

  Stream<DocumentSnapshot> getNotifySnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(this.userId)
        .snapshots();
  }

  getStatusSnapshots() {
    List<String> targetPath = ['users', userId];
    final documentStream = FirebaseFirestore.instance
        .collection(targetPath[0])
        .doc(targetPath[1])
        .snapshots();

    return documentStream;
  }

  Future<FirestoreNotifyModel> getNotify() async {
    DocumentSnapshot result = await notifyInstance!.doc(userId).get();
    return result.data() as FirestoreNotifyModel;
  }

  Future setNotify(NotifyModel NotifyData) async {
    FirestoreNotifyModel currentNoti =
        FirestoreNotifyModel(alreadySeen: false, notify: []);
    try {
      currentNoti = await getNotify();
    } catch (e) {}
    try {
      await firestore.collection('users').doc(userId).update({
        'notify': [
          ...currentNoti.notify
              .map((e) =>
                  {'body': e.body, 'sentTime': e.sentTime, 'title': e.title})
              .toList(),
          NotifyData.toJson()
        ]
      });
    } catch (_, stack) {
      logger.e('Exception: ' + _.toString());
      logger.e('Stacktrace: ' + stack.toString());
    }
  }

  Future setFlagNotify(bool status) async {
    try {
      await firestore
          .collection('users')!
          .doc(userId)
          .update({'alreadySeen': status});
    } catch (_, stack) {
      logger.e('Exception: ' + _.toString());
      logger.e('Stacktrace: ' + stack.toString());
    }
  }

  Future getFlagNotify() async {
    List<String> targetPath = ['users', userId];
    FirebaseFirestore tmp = this.firestore;
    final ref = await tmp.collection(targetPath[0]).doc(targetPath[1]);
    DocumentSnapshot result = await ref.get();
    dynamic status = result.data();
    return status?['alreadySeen'];
  }

  Future setFcmToken(String token) async {
    try {
      await firestore
          .collection('users')!
          .doc(userId)
          .set({'fcm_token': token}, SetOptions(merge: true));
    } catch (_, stack) {
      logger.e('Exception: ' + _.toString());
      logger.e('Stacktrace: ' + stack.toString());
    }
  }

  Future getFcmToken() async {
    List<String> targetPath = ['users', userId];
    FirebaseFirestore tmp = this.firestore;
    final ref = await tmp.collection(targetPath[0]).doc(targetPath[1]);
    DocumentSnapshot result = await ref.get();
    dynamic status = result.data();
    return status?['fcm_token'];
  }
}
