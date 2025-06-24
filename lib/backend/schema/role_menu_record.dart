import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RoleMenuRecord extends FirestoreRecord {
  RoleMenuRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "menuName" field.
  List<String>? _menuName;
  List<String> get menuName => _menuName ?? const [];
  bool hasMenuName() => _menuName != null;

  // "menuHo" field.
  List<bool>? _menuHo;
  List<bool> get menuHo => _menuHo ?? const [];
  bool hasMenuHo() => _menuHo != null;

  // "menuBranch" field.
  List<bool>? _menuBranch;
  List<bool> get menuBranch => _menuBranch ?? const [];
  bool hasMenuBranch() => _menuBranch != null;

  // "menuGBM" field.
  List<bool>? _menuGBM;
  List<bool> get menuGBM => _menuGBM ?? const [];
  bool hasMenuGBM() => _menuGBM != null;

  // "menuASM" field.
  List<bool>? _menuASM;
  List<bool> get menuASM => _menuASM ?? const [];
  bool hasMenuASM() => _menuASM != null;

  // "menuAssistant" field.
  List<bool>? _menuAssistant;
  List<bool> get menuAssistant => _menuAssistant ?? const [];
  bool hasMenuAssistant() => _menuAssistant != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _menuName = getDataList(snapshotData['menuName']);
    _menuHo = getDataList(snapshotData['menuHo']);
    _menuBranch = getDataList(snapshotData['menuBranch']);
    _menuGBM = getDataList(snapshotData['menuGBM']);
    _menuASM = getDataList(snapshotData['menuASM']);
    _menuAssistant = getDataList(snapshotData['menuAssistant']);
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('role_menu');

  static Stream<RoleMenuRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RoleMenuRecord.fromSnapshot(s));

  static Future<RoleMenuRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RoleMenuRecord.fromSnapshot(s));

  static RoleMenuRecord fromSnapshot(DocumentSnapshot snapshot) =>
      RoleMenuRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RoleMenuRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RoleMenuRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RoleMenuRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RoleMenuRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRoleMenuRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class RoleMenuRecordDocumentEquality implements Equality<RoleMenuRecord> {
  const RoleMenuRecordDocumentEquality();

  @override
  bool equals(RoleMenuRecord? e1, RoleMenuRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.menuName, e2?.menuName) &&
        listEquality.equals(e1?.menuHo, e2?.menuHo) &&
        listEquality.equals(e1?.menuBranch, e2?.menuBranch) &&
        listEquality.equals(e1?.menuGBM, e2?.menuGBM) &&
        listEquality.equals(e1?.menuASM, e2?.menuASM) &&
        listEquality.equals(e1?.menuAssistant, e2?.menuAssistant) &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(RoleMenuRecord? e) => const ListEquality().hash([
        e?.menuName,
        e?.menuHo,
        e?.menuBranch,
        e?.menuGBM,
        e?.menuASM,
        e?.menuAssistant,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is RoleMenuRecord;
}
