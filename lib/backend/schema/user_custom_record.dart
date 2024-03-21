import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class UserCustomRecord extends FirestoreRecord {
  UserCustomRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "eployee_id" field.
  String? _eployeeId;
  String get eployeeId => _eployeeId ?? '';
  bool hasEployeeId() => _eployeeId != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "profile_img" field.
  String? _profileImg;
  String get profileImg => _profileImg ?? '';
  bool hasProfileImg() => _profileImg != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_date" field.
  DateTime? _createdDate;
  DateTime? get createdDate => _createdDate;
  bool hasCreatedDate() => _createdDate != null;

  void _initializeFields() {
    _eployeeId = snapshotData['eployee_id'] as String?;
    _email = snapshotData['email'] as String?;
    _profileImg = snapshotData['profile_img'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdDate = snapshotData['created_date'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('UserCustom');

  static Stream<UserCustomRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserCustomRecord.fromSnapshot(s));

  static Future<UserCustomRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserCustomRecord.fromSnapshot(s));

  static UserCustomRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserCustomRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserCustomRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserCustomRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserCustomRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserCustomRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserCustomRecordData({
  String? eployeeId,
  String? email,
  String? profileImg,
  String? uid,
  DateTime? createdDate,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'eployee_id': eployeeId,
      'email': email,
      'profile_img': profileImg,
      'uid': uid,
      'created_date': createdDate,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserCustomRecordDocumentEquality implements Equality<UserCustomRecord> {
  const UserCustomRecordDocumentEquality();

  @override
  bool equals(UserCustomRecord? e1, UserCustomRecord? e2) {
    return e1?.eployeeId == e2?.eployeeId &&
        e1?.email == e2?.email &&
        e1?.profileImg == e2?.profileImg &&
        e1?.uid == e2?.uid &&
        e1?.createdDate == e2?.createdDate;
  }

  @override
  int hash(UserCustomRecord? e) => const ListEquality()
      .hash([e?.eployeeId, e?.email, e?.profileImg, e?.uid, e?.createdDate]);

  @override
  bool isValidKey(Object? o) => o is UserCustomRecord;
}
