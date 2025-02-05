import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HolidayStorageRecord extends FirestoreRecord {
  HolidayStorageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "url_file_holiday" field.
  String? _urlFileHoliday;
  String get urlFileHoliday => _urlFileHoliday ?? '';
  bool hasUrlFileHoliday() => _urlFileHoliday != null;

  void _initializeFields() {
    _urlFileHoliday = snapshotData['url_file_holiday'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('HolidayStorage');

  static Stream<HolidayStorageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HolidayStorageRecord.fromSnapshot(s));

  static Future<HolidayStorageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => HolidayStorageRecord.fromSnapshot(s));

  static HolidayStorageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HolidayStorageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HolidayStorageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HolidayStorageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HolidayStorageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is HolidayStorageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createHolidayStorageRecordData({
  String? urlFileHoliday,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'url_file_holiday': urlFileHoliday,
    }.withoutNulls,
  );

  return firestoreData;
}

class HolidayStorageRecordDocumentEquality
    implements Equality<HolidayStorageRecord> {
  const HolidayStorageRecordDocumentEquality();

  @override
  bool equals(HolidayStorageRecord? e1, HolidayStorageRecord? e2) {
    return e1?.urlFileHoliday == e2?.urlFileHoliday;
  }

  @override
  int hash(HolidayStorageRecord? e) =>
      const ListEquality().hash([e?.urlFileHoliday]);

  @override
  bool isValidKey(Object? o) => o is HolidayStorageRecord;
}
