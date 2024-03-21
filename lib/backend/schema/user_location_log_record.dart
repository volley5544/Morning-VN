import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class UserLocationLogRecord extends FirestoreRecord {
  UserLocationLogRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "employee_id" field.
  String? _employeeId;
  String get employeeId => _employeeId ?? '';
  bool hasEmployeeId() => _employeeId != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "date_time" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  void _initializeFields() {
    _employeeId = snapshotData['employee_id'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _dateTime = snapshotData['date_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('UserLocationLog');

  static Stream<UserLocationLogRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserLocationLogRecord.fromSnapshot(s));

  static Future<UserLocationLogRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserLocationLogRecord.fromSnapshot(s));

  static UserLocationLogRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserLocationLogRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserLocationLogRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserLocationLogRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserLocationLogRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserLocationLogRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserLocationLogRecordData({
  String? employeeId,
  LatLng? location,
  DateTime? dateTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'employee_id': employeeId,
      'location': location,
      'date_time': dateTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserLocationLogRecordDocumentEquality
    implements Equality<UserLocationLogRecord> {
  const UserLocationLogRecordDocumentEquality();

  @override
  bool equals(UserLocationLogRecord? e1, UserLocationLogRecord? e2) {
    return e1?.employeeId == e2?.employeeId &&
        e1?.location == e2?.location &&
        e1?.dateTime == e2?.dateTime;
  }

  @override
  int hash(UserLocationLogRecord? e) =>
      const ListEquality().hash([e?.employeeId, e?.location, e?.dateTime]);

  @override
  bool isValidKey(Object? o) => o is UserLocationLogRecord;
}
