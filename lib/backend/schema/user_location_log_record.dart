import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserLocationLogRecord extends FirestoreRecord {
  UserLocationLogRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
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

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "device_id" field.
  String? _deviceId;
  String get deviceId => _deviceId ?? '';
  bool hasDeviceId() => _deviceId != null;

  // "operating_system" field.
  String? _operatingSystem;
  String get operatingSystem => _operatingSystem ?? '';
  bool hasOperatingSystem() => _operatingSystem != null;

  void _initializeFields() {
    _employeeId = snapshotData['employee_id'] as String?;
    _location = snapshotData['location'] as LatLng?;
    _dateTime = snapshotData['date_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _deviceId = snapshotData['device_id'] as String?;
    _operatingSystem = snapshotData['operating_system'] as String?;
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
  String? phoneNumber,
  String? deviceId,
  String? operatingSystem,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'employee_id': employeeId,
      'location': location,
      'date_time': dateTime,
      'phone_number': phoneNumber,
      'device_id': deviceId,
      'operating_system': operatingSystem,
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
        e1?.dateTime == e2?.dateTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.deviceId == e2?.deviceId &&
        e1?.operatingSystem == e2?.operatingSystem;
  }

  @override
  int hash(UserLocationLogRecord? e) => const ListEquality().hash([
        e?.employeeId,
        e?.location,
        e?.dateTime,
        e?.phoneNumber,
        e?.deviceId,
        e?.operatingSystem
      ]);

  @override
  bool isValidKey(Object? o) => o is UserLocationLogRecord;
}
