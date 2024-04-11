import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class ApplicationConfigRecord extends FirestoreRecord {
  ApplicationConfigRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "version" field.
  String? _version;
  String get version => _version ?? '';
  bool hasVersion() => _version != null;

  // "build_number" field.
  String? _buildNumber;
  String get buildNumber => _buildNumber ?? '';
  bool hasBuildNumber() => _buildNumber != null;

  void _initializeFields() {
    _version = snapshotData['version'] as String?;
    _buildNumber = snapshotData['build_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ApplicationConfig');

  static Stream<ApplicationConfigRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ApplicationConfigRecord.fromSnapshot(s));

  static Future<ApplicationConfigRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ApplicationConfigRecord.fromSnapshot(s));

  static ApplicationConfigRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ApplicationConfigRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ApplicationConfigRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ApplicationConfigRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ApplicationConfigRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ApplicationConfigRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createApplicationConfigRecordData({
  String? version,
  String? buildNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'version': version,
      'build_number': buildNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class ApplicationConfigRecordDocumentEquality
    implements Equality<ApplicationConfigRecord> {
  const ApplicationConfigRecordDocumentEquality();

  @override
  bool equals(ApplicationConfigRecord? e1, ApplicationConfigRecord? e2) {
    return e1?.version == e2?.version && e1?.buildNumber == e2?.buildNumber;
  }

  @override
  int hash(ApplicationConfigRecord? e) =>
      const ListEquality().hash([e?.version, e?.buildNumber]);

  @override
  bool isValidKey(Object? o) => o is ApplicationConfigRecord;
}
