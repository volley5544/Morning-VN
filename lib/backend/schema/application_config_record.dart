import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApplicationConfigRecord extends FirestoreRecord {
  ApplicationConfigRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
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

  // "version_ios" field.
  String? _versionIos;
  String get versionIos => _versionIos ?? '';
  bool hasVersionIos() => _versionIos != null;

  // "build_number_ios" field.
  String? _buildNumberIos;
  String get buildNumberIos => _buildNumberIos ?? '';
  bool hasBuildNumberIos() => _buildNumberIos != null;

  void _initializeFields() {
    _version = snapshotData['version'] as String?;
    _buildNumber = snapshotData['build_number'] as String?;
    _versionIos = snapshotData['version_ios'] as String?;
    _buildNumberIos = snapshotData['build_number_ios'] as String?;
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
  String? versionIos,
  String? buildNumberIos,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'version': version,
      'build_number': buildNumber,
      'version_ios': versionIos,
      'build_number_ios': buildNumberIos,
    }.withoutNulls,
  );

  return firestoreData;
}

class ApplicationConfigRecordDocumentEquality
    implements Equality<ApplicationConfigRecord> {
  const ApplicationConfigRecordDocumentEquality();

  @override
  bool equals(ApplicationConfigRecord? e1, ApplicationConfigRecord? e2) {
    return e1?.version == e2?.version &&
        e1?.buildNumber == e2?.buildNumber &&
        e1?.versionIos == e2?.versionIos &&
        e1?.buildNumberIos == e2?.buildNumberIos;
  }

  @override
  int hash(ApplicationConfigRecord? e) => const ListEquality()
      .hash([e?.version, e?.buildNumber, e?.versionIos, e?.buildNumberIos]);

  @override
  bool isValidKey(Object? o) => o is ApplicationConfigRecord;
}
