import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChgLocationPermRecord extends FirestoreRecord {
  ChgLocationPermRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "emp_id" field.
  List<String>? _empId;
  List<String> get empId => _empId ?? const [];
  bool hasEmpId() => _empId != null;

  void _initializeFields() {
    _empId = getDataList(snapshotData['emp_id']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ChgLocationPerm');

  static Stream<ChgLocationPermRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChgLocationPermRecord.fromSnapshot(s));

  static Future<ChgLocationPermRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ChgLocationPermRecord.fromSnapshot(s));

  static ChgLocationPermRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChgLocationPermRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChgLocationPermRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChgLocationPermRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChgLocationPermRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChgLocationPermRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createChgLocationPermRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class ChgLocationPermRecordDocumentEquality
    implements Equality<ChgLocationPermRecord> {
  const ChgLocationPermRecordDocumentEquality();

  @override
  bool equals(ChgLocationPermRecord? e1, ChgLocationPermRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.empId, e2?.empId);
  }

  @override
  int hash(ChgLocationPermRecord? e) => const ListEquality().hash([e?.empId]);

  @override
  bool isValidKey(Object? o) => o is ChgLocationPermRecord;
}
